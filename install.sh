#!/bin/sh

CUR_DIR="$(pwd)"
DOT_DIR="$(dirname "$(pwd)"/"$0")/"
DEF_DIR="$DOT_DIR/default"

recurselink(){
        FROM="$1"
        TO="$2"
        cd "$FROM" || return
        for i in * .*; do
                if [ "$i" = "." ] || [ "$i" = ".." ]; then
                        continue
                fi
                if [ ! -e "$TO/$i" ] ; then
                        ln -s "$FROM/$i" "$TO/$i"
                elif [ ! -L "$TO/$i" ] ; then
                        recurselink "$FROM" "$TO/$i"
                fi
        done
}

recurselink "$DEF_DIR" "$HOME"

cd "$CUR_DIR" || exit
