---
name: device-bootstrap
description: Walk through onboarding a new or reset device into the personal fleet (laptop, macOS, or shared workstation) — Tailscale, per-device SSH key, Ansible pull-based bootstrap, dotfiles symlinks, and ~/.claude setup. Use when setting up a new machine, re-provisioning one, or asked to bootstrap/onboard a device.
---

# Device bootstrap

Onboards a device into the same fleet as this one: `~/.ansible` (pull-based,
Tailscale-identified) + `~/.dotfiles` (symlinked shell/git/tmux/nvim/ghostty
config) + a per-device `~/.claude` setup. Ask which device type this is
(laptop / macOS laptop / shared server-class workstation) before starting —
step 4 branches on it.

## 0. Truly blank device (no Claude Code, no repos yet)

If this skill is running, Claude Code and — because it's clone-symlinked
from `~/.dotfiles/.claude/skills` — the dotfiles repo already exist on this
box, so steps 1–4 below are already done or redundant. This is the normal
case when the user asks Claude to bootstrap a device it's already sitting
on.

The actual zero-to-fleet path for a device that has *nothing* yet is
`~/.dotfiles/bootstrap-device.sh`, run via
`bash <(curl -fsSL <raw-url-to-bootstrap-device.sh>) [laptop|server|macos]`
— hosted as a secret (unlisted) GitHub Gist or the dotfiles repo's raw URL,
since it needs to run before any SSH key or cloned repo exists to fetch it
another way. It's plain bash, contains no embedded secrets (it only ever
*generates* a key locally and pauses for the user to register the public
half), and does steps 1–4 below itself: installs prerequisites via
apt/Homebrew depending on `uname`, generates the SSH key, pauses for
Bitbucket registration, installs Tailscale, clones `~/.ansible`, and runs
the right `bootstrap_*.sh`. If asked to help someone bootstrap a device
that doesn't have Claude Code on it yet, point them at this script rather
than trying to talk them through the equivalent steps by hand over chat —
and read it with them before they run it, same as any other curl-pipe-bash
install.

If it needs updating (new OS branch, changed remote URL, etc.), edit
`~/.dotfiles/bootstrap-device.sh` directly and keep the gist (if one
exists) in sync by re-pasting its content — don't fork the logic across
both places.

## 1. Join the tailnet

```bash
curl -fsSL https://tailscale.com/install.sh | sh   # macOS: brew install --cask tailscale
sudo tailscale up
```

No `--ssh` — deliberately not using Tailscale SSH. Access goes through
plain `sshd` and the keys `~/.ansible`'s `user_profile` role already
manages via `authorized_keys`, same as every named `Host` in
`~/.ssh/config` already does. This keeps SSH working identically whether
or not Tailscale itself is up, at the cost of manual key rotation via
Ansible instead of instant tailnet-ACL revocation — a reasonable tradeoff
for a small personal fleet.

## 2. Register this device's Tailscale IP

`tailscale ip -4` on the new device, then add it to this user's
`tailscale_ips` list in `~/.ansible/inventories/group_vars/all.yml` (edit on
an existing machine and push, or edit directly if this device already has
the repo). This is how the pull-based bootstrap identifies *who* is running
it without a hostname convention.

## 3. Generate a device-local SSH key — never copy one over

One key per device, so a lost device is a five-minute revoke instead of a
fleet-wide rotation. Do not reuse a private key file from another machine.

```bash
ssh-keygen -t ed25519 -C "$(hostname)-$(date +%Y%m)" -f ~/.ssh/id_ed25519 -N ""
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

Then **stop and tell the user to add this public key to Bitbucket** (Personal
settings → SSH keys) before continuing — don't assume it's already there.
Confirm with a test: `ssh -T git@bitbucket.org`.

## 4. Clone and run Ansible

```bash
git clone git@bitbucket.org:<org>/ansible.git ~/.ansible   # or the actual remote
cd ~/.ansible
```

Then, by device type:

- **Linux laptop**: `./bootstrap_laptop.sh`
- **macOS**: confirm `roles/device_specific/tasks/main.yml` branches on
  `ansible_os_family == "Darwin"` into a Homebrew-based `core_macos.yml`
  before running — if that branch doesn't exist yet, this is new territory,
  say so and add it rather than running the Debian/apt path against macOS.
  Then: `ansible-playbook playbooks/bootstrap_device.yml -e device_type=laptop`.
- **Shared/server-class workstation**: check whether this hostname exists
  under `inventories/servers/hosts.yml` first — if not, that's a gap to fix
  (see `dotfiles-doctor` for the general pattern of catching untracked
  machine state), then run the server bootstrap.

This installs core packages, pixi, tmuxp, fzf, ghostty, and — via the
`dotfiles` role — clones `~/.dotfiles` and symlinks it into place per
`roles/dotfiles/tasks/main.yml`.

## 5. Verify the dotfiles symlinks actually landed

Don't just trust the Ansible run succeeded — run the `dotfiles-doctor`
skill's checks 1–4 against this device. In particular:

```bash
zsh -c 'echo $ZDOTDIR'          # -> ~/.config/zsh, not empty
git config --get alias.st       # -> status (confirms .gitconfig symlink + include)
pixi --version && tmuxp --version && ghostty +show-config >/dev/null && echo ok
```

## 6. Set up `~/.claude`

```bash
cp ~/.dotfiles/.claude/CLAUDE.md.template ~/.claude/CLAUDE.md
```

Edit the hostname placeholder, delete whichever machine-specific sections
don't apply (a plain laptop usually keeps none of Storage layout / Port
registry / GPU layout — a shared workstation usually needs at least Port
registry). Then diff `~/.dotfiles/.claude/settings.json.sample` against
`~/.claude/settings.json` and merge the shareable prefs by hand — don't
overwrite the live file, it also holds machine-local state the sample
intentionally omits. See `~/.dotfiles/.claude/README.md` for why none of
this is a straight symlink.

## 7. Known gaps to flag, not silently work around

- No macOS branch in `device_specific/core.yml` as of the last audit — if
  bootstrapping a Mac and this still isn't fixed, say so and propose the
  fix rather than hand-installing packages outside Ansible.
- `device_specific/robot.yml` assumes Raspberry Pi (`/boot/config.txt`,
  `raspberrypi-sys-mods`) — do not run it against Jetson hardware
  unmodified.
