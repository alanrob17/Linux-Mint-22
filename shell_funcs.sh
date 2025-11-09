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

