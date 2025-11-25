# TMUX
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tad='tmux attach -d -t'
alias tns='tmux new-session -s'
alias tks='tmux kill-session'
alias tkser='tmux kill-server'
alias td='tmux detach-client'
alias tsls='lsof -U | grep tmp/tmux'
alias tj='tmux-jump'

# Git
alias gs='git status'
alias gco='git checkout'
alias gp='git push'
alias ga='git add'
alias gci='git commit'
alias gsw='git config --local user.name "${GIT_AUTHOR_NAME}" && git config --local user.email "${GIT_AUTHOR_EMAIL}"'
# ROS per-use
#alias humble='source $HOME/.config/ros/ros2_env humble'
#alias ross='source $HOME/.config/ros/ros_env'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias doc='cd $HOME/Documents'
alias dow='cd $HOME/Downloads'

# Editor
#alias vim='nvim'
