export PS1='[\e[0;32m\t \e[0;34m\w\e[m$(__git_ps1 " (\e[0;31m%s\e[m)")]\n\u@\h:\$ '

alias gs='git status'
alias gd='git diff'
alias gc='docker exec -it -w ${PWD#$HOME} -e GIT_CONFIG=/opt/dev/gitconfig docker-dev git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias gcb='git checkout -b'
alias ga='git add'
alias gl='git log'
alias gsl='git stash list'
alias gsp='git stash pop'

dev()
{
    if [[ $(docker ps -qf "name=docker-dev") ]];
    then
      docker exec -it -w ${PWD#$HOME} docker-dev /bin/ash --login
    else
      docker run -it --rm -d --net="host" -h docker-dev -v ~/src:/src -v home:/home/dev -w ${PWD#$HOME} --name docker-dev docker-dev && dev
    fi
}

set -o vi
source ~/.git-prompt.sh
export PATH=$PATH:~/.local/bin
