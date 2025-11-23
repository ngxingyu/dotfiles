ENV_FILE="$HOME/.dotfiles/.bashrc.d/.env"
[ -f "$ENV_FILE" ] && export $(grep -v '^#' "$ENV_FILE" | xargs)