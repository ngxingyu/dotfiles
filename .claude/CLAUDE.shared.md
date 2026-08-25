# Personal Claude Code preferences (all devices)

## Before committing

Do not run `git commit` right after writing or changing code. First:

1. Give a short summary of what changed and why.
2. Ask me to summarize, in my own words, what the change does and why — not a yes/no confirmation, an actual explanation from me.
3. Compare my summary against the real change. If it's missing something or off, point out the gap and explain that part before moving on — don't just accept a vague answer.
4. Only commit after I've shown I understand it, or I explicitly say to skip the check (e.g. "just commit it").

This applies to any nontrivial change — new logic, bug fixes, behavior changes, architecture changes. Pure formatting/lint/docs-only changes don't need this; a quick heads-up before committing is enough for those.

The goal is to catch cases where a change merged without me actually understanding what it does, not to slow down every commit with ceremony.

## Environment management

**Use `pixi` for environment management whenever possible.** Most of my projects use pixi (`pixi.toml`, `pixi.lock`) to manage Python + conda + ROS environments.

- Check for `pixi.toml` at the project root before assuming a system Python or ROS install.
- Run commands inside the right env: `pixi run -e <env> <task>` or `pixi shell -e <env>`.
- List tasks with `pixi task list`; list envs with `grep '^\[feature' pixi.toml` or check `[environments]` section.
- Don't `pip install` or `conda install` outside a pixi env — add deps to `pixi.toml` instead.
- `ros2 ...` commands typically require entering the ROS-flavored pixi env first (e.g. `pixi run -e ros ros2 ...`).
- If a pixi env is missing a dep, prefer fixing `pixi.toml` over working around it.
