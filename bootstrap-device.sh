#!/usr/bin/env bash
# ~/.dotfiles/bootstrap-device.sh
#
# Stage-0 bootstrap for a brand-new device: runs BEFORE ~/.ansible or
# ~/.dotfiles exist on the box, so it can't depend on either. Its only job
# is to get far enough that the `device-bootstrap` Claude Code skill (in
# this repo, ~/.dotfiles/.claude/skills/device-bootstrap/) can take over
# for everything that needs judgment.
#
# Usage:
#   bash <(curl -fsSL <raw-url-to-this-file>) [laptop|server|macos]
#
# IMPORTANT: use `bash <(curl ...)`, NOT `curl ... | bash`. Piping to bash
# makes this script's stdin the curl output, not your terminal, so the
# `read` prompt below (waiting for you to register the SSH key) can't
# work. Process substitution keeps stdin attached to your real terminal.
# (The script also falls back to reading from /dev/tty directly, in case
# it's invoked piped anyway -- but prefer the <(...) form.)
#
# This script contains no secrets and never will -- it only ever generates
# a key locally and tells you what to do with the public half. Read it
# before running it, same as you would anyone else's install script.

set -euo pipefail

DEVICE_TYPE="${1:-}"
READ_TTY() { read -rp "$1" "$2" < /dev/tty 2>/dev/null || read -rp "$1" "$2"; }

echo "== Detecting OS =="
OS="$(uname -s)"
case "$OS" in
  Linux)  PKG_INSTALL() { sudo apt-get update -y && sudo apt-get install -y "$@"; } ;;
  Darwin) command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          PKG_INSTALL() { brew install "$@"; } ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac
echo "-> $OS"

echo "== Prerequisites (git, openssh, curl) =="
if [ "$OS" = Linux ]; then PKG_INSTALL git openssh-client curl; fi
# macOS ships git/ssh/curl already.

echo "== SSH key: one per device, never copied from elsewhere =="
if [ -f ~/.ssh/id_ed25519 ]; then
  echo "-> ~/.ssh/id_ed25519 already exists, leaving it alone."
else
  ssh-keygen -t ed25519 -C "$(hostname)-$(date +%Y%m)" -f ~/.ssh/id_ed25519 -N ""
fi
eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1 || true

echo
echo "############################################################"
echo "# Add this public key to GitHub now (needed to clone"
echo "# ~/.ansible and ~/.dotfiles, both hosted there):"
echo "#   https://github.com/settings/ssh/new"
echo "#"
echo "# If this device will also work on Bitbucket-hosted team repos"
echo "# (e.g. embodied_nav_ws), add the same key there too:"
echo "#   https://bitbucket.org/account/settings/ssh-keys/"
echo "############################################################"
cat ~/.ssh/id_ed25519.pub
echo
READ_TTY "Press Enter once it's added to GitHub (or Ctrl-C to stop here and finish manually): " _

echo "== Verifying GitHub access =="
ssh -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 | grep -qi "successfully authenticated" \
  && echo "-> OK" \
  || { echo "-> Couldn't confirm access yet. Re-run this script, or continue manually from the device-bootstrap skill once it's sorted."; }

echo "== Tailscale =="
if ! command -v tailscale >/dev/null; then
  if [ "$OS" = Linux ]; then curl -fsSL https://tailscale.com/install.sh | sh
  else PKG_INSTALL --cask tailscale; fi
fi
sudo tailscale up --ssh || tailscale up --ssh || echo "-> run 'tailscale up --ssh' manually (may need interactive auth)"

echo "== Device type =="
if [ -z "$DEVICE_TYPE" ]; then
  READ_TTY "Device type [laptop/server/macos]: " DEVICE_TYPE
fi

echo "== Cloning ~/.ansible =="
if [ -d ~/.ansible/.git ]; then
  echo "-> ~/.ansible already present, pulling latest"
  git -C ~/.ansible pull
else
  git clone git@github.com:ngxingyu/ansible.git ~/.ansible
fi

echo "== Running Ansible bootstrap ($DEVICE_TYPE) =="
cd ~/.ansible
case "$DEVICE_TYPE" in
  laptop) ./bootstrap_laptop.sh ;;
  server) ./bootstrap_server.sh ;;
  macos)  ansible-playbook playbooks/bootstrap_device.yml -e device_type=laptop ;;
  *) echo "Unrecognized device type '$DEVICE_TYPE' -- run the right bootstrap_*.sh manually." ;;
esac

echo
echo "== Stage 0 done. Hand off to Claude Code =="
echo "~/.dotfiles and ~/.ansible are in place. Install Claude Code if you"
echo "haven't (https://claude.com/claude-code), cd into ~/.dotfiles or"
echo "~/.ansible, and ask it to run the 'device-bootstrap' skill (it's"
echo "symlinked to ~/.claude/skills already) to verify everything landed"
echo "correctly and finish the ~/.claude setup."
