alias lla='eza -la --group-directories-first'
alias lt='eza --size -1 -S --classify'
alias ls='eza'
alias gh='history|grep'
alias cls='clear'
alias upd='sudo apt-get update -y && sudo apt-get upgrade -y'
alias gs='git status'
alias ga='git add .'
alias gp='git push'
alias gc=~/gc.sh
alias gl='git log'
# alias cn='sudo mount.cifs //tiger/virtual ~/share -o user=alanr'
# alias cn='sudo mount.cifs //tiger/virtual ~/share -o user=alanr'
alias dc='docker'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dv='docker ps --format="$FORMAT"'
alias pf="ps -e | grep $1"
alias bc='batcat'
alias cat='batcat'
alias fd='fdfind'
alias nan='nano $(fzf --preview="batcat --color=always {}")'
alias gcom='git log --oneline | fzf --preview "git show --name-only {1}"'
alias pf='fzf --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
alias f=fzf
alias la=eza
alias co=code
