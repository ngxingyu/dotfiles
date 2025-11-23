[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="${HOME}/.pixi/bin:$PATH"
# BEGIN ANSIBLE MANAGED BLOCK: DOTFILES
# Source user custom zshrc scripts
if [ -d "$HOME/.dotfiles/.zshrc.d" ]; then
  for f in "$HOME/.dotfiles/.zshrc.d/"*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi
# END ANSIBLE MANAGED BLOCK: DOTFILES

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "brucechanjianle/fzf-tab"
plug "brucechanjianle/zsh-copybuffer"
plug "brucechanjianle/fzf-file-source"
plug "Tarrasch/zsh-autoenv"

plug $ZDOTDIR/zsh-autosuggestions.zsh
plug $ZDOTDIR/fzf-tab.zsh