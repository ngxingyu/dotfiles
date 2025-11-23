# Color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# LS shortcuts
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Alert for long-running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Source user's .bash_aliases scripts (optional)
if [ -f "$HOME/.dotfiles/.bash_aliases" ]; then
    . "$HOME/.dotfiles/.bash_aliases"
fi
