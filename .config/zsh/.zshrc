# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# BEGIN ANSIBLE MANAGED BLOCK: DOTFILES
# Source user custom zshrc scripts
if [ -d "$HOME/.dotfiles/.zshrc.d" ]; then
  for f in "$HOME/.dotfiles/.zshrc.d/"*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi
# END ANSIBLE MANAGED BLOCK: DOTFILES
