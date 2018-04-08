#!/bin/sh

set -e

CUR_DIR="$(pwd)"
DOT_DIR="$(dirname "$(pwd)"/"$0")/"
DEF_DIR="$DOT_DIR/default"

# Note: The parens are useful here! They mean the function should be executed
# in a subshell, which protects us from the environment being modified in
# recursive calls
recurselink()(
        FROM="$1"
        TO="$2"
        cd "$FROM"
        for i in * .*; do
                if [ "$i" = "." ] || [ "$i" = ".." ]; then
                        continue
                fi
                if [ ! -e "$TO/$i" ] ; then
                        ln -s "$FROM/$i" "$TO/$i"
                elif [ -d "$FROM/$i" ] && [ ! -L "$TO/$i" ] ; then
                        recurselink "$FROM/$i" "$TO/$i"
                fi
        done
)

recurselink "$DEF_DIR" "$HOME"

cd "$CUR_DIR"
