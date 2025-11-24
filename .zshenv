export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# ref: https://wiki.archlinux.org/title/XDG_Base_Directory

export EDITOR="nvim"
export VISUAL="nvim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

if ! env | grep -qs PATH | grep -qs ".local/bin"; then
  export PATH=$HOME/.local/bin:$PATH
fi