# Only run if interactive
[[ -o interactive ]] || return

# Include hidden files.
_comp_options+=(globdots)

# History
HISTSIZE=10000
SAVEHIST=10000
setopt append_history share_history


# Optional: reset prompt after each command
if [[ -n $ZLE ]]; then
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd () { emulate -L zsh; zle reset-prompt }
fi

# Enable vcs_info for git branch display
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a)'

# Set prompt to show current directory and git branch
PROMPT='%n@%m %~ ${vcs_info_msg_0_} %# '