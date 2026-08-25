# ~/.claude config, tracked

`~/.claude/CLAUDE.md` and `~/.claude/settings.json` are **not** symlinked here —
Claude Code writes live runtime state into files alongside them (daemon
state, session history, `autoMode` context it infers per project), so
turning either into a straight symlink into git would mean the app's own
writes constantly dirty the tracked file. These are starting points to
copy from instead:

- **`CLAUDE.shared.md`** — personal preferences that are true on every
  device (commit-review workflow, pixi usage). `~/.claude/CLAUDE.md` on
  each machine imports this with `@~/.dotfiles/.claude/CLAUDE.shared.md`
  at the top, then adds whatever is actually specific to that machine
  below it (storage layout, port registry, GPU layout — servers/workstations
  only). Edit `CLAUDE.shared.md` once, every device picks it up next
  session.

- **`CLAUDE.md.template`** — what a brand new device's `~/.claude/CLAUDE.md`
  starts as: `cp CLAUDE.md.template ~/.claude/CLAUDE.md`, fill in the
  hostname, delete whichever machine-specific sections don't apply (a
  laptop usually keeps none of them).

- **`settings.json.sample`** — the shareable subset of Claude Code
  settings (model, theme, effort level, enabled plugins). Diff it against
  a new device's `~/.claude/settings.json` and merge by hand rather than
  overwriting — the live file also holds machine-local state this sample
  intentionally leaves out.

- **`skills/`** — unlike the files above, this *is* symlinked outright as
  `~/.claude/skills` (Ansible's `dotfiles` role does this, or on an
  existing machine: `ln -sf ~/.dotfiles/.claude/skills ~/.claude/skills`).
  Skills are static instructions, not runtime-mutated, so there's no
  drift risk. Two live here:
  - `dotfiles-doctor` — audits this repo + the live symlinks for the kinds
    of silent breakage that have actually happened (dangling gitlinks,
    shell-loader glob mismatches, un-symlinked drifted files, missing
    `$ZDOTDIR` wiring) and fixes them.
  - `device-bootstrap` — walks a new or reset device through Tailscale,
    a fresh per-device SSH key, the Ansible pull-based bootstrap, and
    seeding `~/.claude` from the template above.
