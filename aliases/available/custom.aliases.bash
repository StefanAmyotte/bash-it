# bin paths
export PATH=$PATH:/home/stefan/bin/scala/bin
export PATH=$PATH:/home/stefan/bin/bro/bin
export PATH=$PATH:/home/stefan/bin/node/bin
export PATH=$PATH:/home/stefan/bin/phantomjs/bin

alias fucking=sudo
alias c2='ssh phirelight@c2'
alias analytics='ssh phirelight@analytics'
alias portal='ssh phirelight@portal'
alias h='history | grep $1'

# common mispelled commands
alias xs='cd'
alias vf='cd'
alias got='git'
alias get='git'
alias gti='git'
alias claer="clear"
alias clera="clear"
alias celar="clear"
alias findgrep='grepfind'
alias mann='man'
alias updtae='update'
alias vmi='vim'

# git
alias gh='git hist'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# advanced ls functions
alias l="ls -1"
alias la='ls -A'
alias ll='ls -haltr'
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al | more'   # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

