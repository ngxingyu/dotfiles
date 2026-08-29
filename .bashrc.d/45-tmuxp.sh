# Auto-exclude tmuxp-loaded sessions from tmux-resurrect/continuum.
#
# tmuxp sessions are already fully reproducible from their config file, so
# resurrect saving/restoring them is redundant at best and can conflict at
# worst (stale panes restored on top of what's supposed to be a fresh
# predefined layout). Rather than hand-maintaining
# @resurrect-exclude-sessions, resolve the session_name straight out of the
# config tmuxp is about to load -- using tmuxp's own config-resolution code
# (find_workspace_file), so "." / bare names / relative paths behave
# exactly like they do for tmuxp itself -- and add it before tmuxp runs.
#
# Only handles the common `tmuxp load [CONFIG]` form (no flags before the
# config arg). Anything fancier just silently skips auto-tagging; the
# manual `tmux set -g @resurrect-exclude-sessions "..."` path still works.
tmuxp() {
  if [ "$1" = "load" ]; then
    local tmuxp_py="$HOME/.pixi/envs/tmuxp/bin/python3"
    [ -x "$tmuxp_py" ] || tmuxp_py="python3"
    local session_name
    session_name="$("$tmuxp_py" - "${2:-.}" 2>/dev/null <<'PYEOF'
import sys
try:
    from tmuxp.workspace.finders import find_workspace_file
    from tmuxp._internal.config_reader import ConfigReader
    import pathlib
    p = find_workspace_file(sys.argv[1])
    print(ConfigReader._from_file(pathlib.Path(p)).get("session_name", ""))
except Exception:
    pass
PYEOF
)"
    if [ -n "$session_name" ]; then
      local current
      current="$(tmux show-option -gqv @resurrect-exclude-sessions 2>/dev/null)"
      case " $current " in
        *" $session_name "*) ;;  # already listed
        *) tmux set -g @resurrect-exclude-sessions "${current:+$current }$session_name" 2>/dev/null ;;
      esac
    fi
  fi
  command tmuxp "$@"
}
