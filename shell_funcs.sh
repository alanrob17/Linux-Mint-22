#!/bin/bash

mkd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

today() {
    date '+%Y-%m-%d'
}

trim() {
    sed 's/^[ \t]*//;s/[ \t]*$//'
}

ucase() {
    tr '[:lower:]' '[:upper:]'
}

lcase() {
    tr '[:upper:]' '[:lower:]'
}

filesize() {
    du -sk * | sort -n
}

paths() {
    echo $PATH | tr ':' '\n'
}

check_paths() {
    paths | while read path
    do
        if [ ! -d "$path" ]; then
            echo "bad PATH: dir does not exist: $path" >&2
        fi
    done
}


# Extract any archive
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Go up n directories
up() {
    local d=""
    local limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# Get public IP
myip() {
    curl http://ipecho.net/plain; echo
}

# Start a simple HTTP server
serve() {
    python3 -m http.server "${1:-8000}"
}

# Backup a file
backup() {
    if [ -f "$1" ]; then
        cp "$1" "${1}.$(date +%Y%m%d).bak"
        echo "Backed up $1 to ${1}.$(date +%Y%m%d).bak"
    else
        echo "File $1 does not exist"
    fi
}

# Get current git branch
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
