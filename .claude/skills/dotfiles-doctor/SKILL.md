---
name: dotfiles-doctor
description: Audit this machine's ~/.dotfiles, ~/.ansible, and shell/git/tmux/ghostty config for drift — dangling git submodules, shell loader glob mismatches, un-symlinked live files, uncommitted local edits, missing ZDOTDIR wiring — and fix what's found. Use when something in the shell/editor/git setup behaves differently than expected, before onboarding a new machine, or when asked to check/fix dotfiles.
---

# Dotfiles doctor

Runs the checks that have historically caught real, silent breakage in this
setup — each one below was found by actually reading files, not by assuming
the intended design matches reality. Do the same: verify, don't assume.

## Checks, in order

1. **Dangling gitlinks.** `git -C ~/.dotfiles ls-files -s | awk '$1=="160000"'`
   — any hit is a directory that got committed as a submodule reference
   without a `.gitmodules` entry. It checks out **empty** on a fresh clone.
   Fix: `git rm --cached <path> && git add <path>/` to convert it to real
   tracked files (verify the working-tree content is actually current
   before doing this — diff against what you'd expect).

2. **Shell-loader glob mismatches.** `~/.bashrc` sources
   `~/.dotfiles/.bashrc.d/*.sh` and `~/.zshrc`'s functional equivalent
   sources `~/.dotfiles/.zshrc.d/*.sh` — literally, via a shell glob. Any
   fragment missing the `.sh` extension (check with
   `ls ~/.dotfiles/.bashrc.d/ ~/.dotfiles/.zshrc.d/` and eyeball for
   outliers) is silently never sourced. This has happened before via an
   accidental rename that dropped the extension.

3. **ZDOTDIR actually wired up.** `~/.zshenv` sets `$ZDOTDIR` to
   `~/.config/zsh`, which is where the *real* `.zshrc` needs to live once
   that's active. Confirm the chain: `~/.zshenv` exists and is a symlink
   into `~/.dotfiles/.zshenv`; `~/.config/zsh` is a symlink into
   `~/.dotfiles/.config/zsh` (not a dangling gitlink — see check 1); run
   `zsh -c 'echo $ZDOTDIR'` and confirm it prints `~/.config/zsh`, not
   empty. If `~/.zshenv` doesn't exist, zsh silently falls back to
   `$HOME/.zshrc`, and anything added to `.config/zsh/.zshrc` is dead code
   nobody sees.

4. **Live file vs. tracked file drift.** For each of
   `.gitconfig .tmux.conf .config/ghostty/config .config/zsh/.zshrc`,
   confirm the live path (`~/.gitconfig` etc.) is actually a symlink
   (`ls -la`) and not a plain file that happened to start from the same
   content. A plain file here means edits made directly on this machine
   never reach `~/.dotfiles`, and other machines never see them. If it's a
   plain file: diff it against the tracked version first — anything that's
   genuinely per-machine (not "this machine happens to be behind") belongs
   in `~/.dotfiles/.zshrc.d/90-local.sh` (gitignored) for shell config, or
   `~/.gitconfig.local` (included via `[include] path = ~/.gitconfig.local`
   at the top of the tracked `.gitconfig`) for git config — not left
   inline in the live file.

5. **Uncommitted drift in `~/.dotfiles` itself.**
   `git -C ~/.dotfiles status --short`. Anything modified/deleted here is
   a real edit sitting only on this machine, at risk of being lost or
   silently diverging from every other device. Don't leave it — either
   commit it (following the commit-review workflow in
   `CLAUDE.shared.md`/the global CLAUDE.md) or explain to the user why it
   shouldn't be tracked and gitignore it properly.

6. **`.gitignore` sanity.** `git -C ~/.dotfiles check-ignore -v .bashrc.d/.env .zshrc.d/90-local.sh .config/zsh/.zcompdump` —
   all three should resolve to a rule. If any doesn't, check whether an
   earlier append landed on the same line as an existing pattern (missing
   trailing newline is the usual cause) rather than as its own line.

7. **Secrets never committed.** `.bashrc.d/.env` (sourced by both shells'
   `60-secrets.sh`) must stay gitignored and untracked:
   `git -C ~/.dotfiles ls-files | grep -x '.bashrc.d/.env'` should print
   nothing.

## When fixing across the fleet

A fix made here (ThinkStation) doesn't reach Vector / Dell G15 / the
MacBook until `~/.dotfiles` is committed, pushed, and each machine runs
`cd ~/.ansible && ./bootstrap.sh` (or `git -C ~/.dotfiles pull` for a
dotfiles-only change). Say so explicitly when a fix is machine-specific
vs. needs propagating.
