# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system.
# compinit's insecure-directory check prompts interactively (read -q) when it
# finds group/other-writable dirs in $fpath (e.g. a freshly git-cloned
# zap/zsh-syntax-highlighting completion dir). In a non-tty context, or if
# that prompt is ever missed, compinit ABORTS -- which skips everything after
# it in this file, silently breaking .zshrc.d/*.sh sourcing below (that's how
# ros2/colcon tab-completion went missing: bashcompinit + argcomplete never
# ran). `-u` skips that prompt outright -- fine on a personal single-user
# machine; run `compaudit` by hand if you ever want to actually fix perms
# instead of just bypassing the check.
autoload -Uz compinit
compinit -u
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# BEGIN ANSIBLE MANAGED BLOCK: DOTFILES
# Source user custom zshrc scripts
if [ -d "$HOME/.dotfiles/.zshrc.d" ]; then
  for f in "$HOME/.dotfiles/.zshrc.d/"*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi
# END ANSIBLE MANAGED BLOCK: DOTFILES
