
# Simple dc wrapper. $1 is input base, $2 is output base, $3 is value
function baseXtoY () {
    dc -e "${1}i${2}o${3}p"
}

function asciichar () {
    [ "$1" -lt 256 ] || return 1
    printf "\\$(printf '%03o' "$1")"
}

function asciinum () {
    LC_CTYPE=C printf '%d' "'$1"
}

# Try to guess input base and convert to base 2
function base2 () {
    for i in "$@:u"
    do
        case "$i[0,2]" in
            "0X")
                baseXtoY 16 2 "$i[3,-1]"
                ;;
            "0B")
                baseXtoY  2 2 "$i[3,-1]"
                ;;
            0*)
                baseXtoY  8 2 "$i[2,-1]"
                ;;
            *)
                baseXtoY 10 2 "$i"
        esac
    done
}

# Try to guess input base and convert to base 8
function base8 () {
    for i in "$@:u"
    do
        case "$i[0,2]" in
            "0X")
                baseXtoY 16 8 "$i[3,-1]"
                ;;
            "0B")
                baseXtoY  2 8 "$i[3,-1]"
                ;;
            0*)
                baseXtoY  8 8 "$i[2,-1]"
                ;;
            *)
                baseXtoY 10 8 "$i"
        esac
    done
}

# Try to guess input base and convert to base 10
function base10 () {
    for i in "$@:u"
    do
        case "$i[0,2]" in
            "0X")
                printf "%i\n" "$i"
                ;;
            "0B")
                printf "%i\n" "$i"
                ;;
            0*)
                echo $((8#$i[2,-1]))
                ;;
            *)
                printf "%i\n" "$i"
        esac
    done
}

# Try to guess input base and convert to base 16
function base16 () {
    for i in "$@:u"
    do
        case "$i[0,2]" in
            "0X")
                printf "%x\n" "$i"
                ;;
            "0B")
                printf "%x\n" "$i"
                ;;
            0*)
                baseXtoY  8 16 "$i[2,-1]"
                ;;
            *)
                printf "%x\n" "$i"
        esac
    done
}

# Wrapper around go binary to provide project-specific gopath
function go () {
    if [[ "$GOPATH" != "" ]]
    then
        command go "$@"
        return
    fi
    local dir="$PWD"
    for i in 0 1 2 3; do
        if [ -d "$dir/.gopath" ]
        then
            GOPATH="$dir/.gopath" command go "$@"
            return
        fi
        dir="$dir/../"
    done
    if [ ! -e "$PWD/.gopath" ]
    then
        mkdir .gopath
    fi
    GOPATH="$PWD/.gopath" command go "$@"
    return
}

# = alias that works as calculator
autoload -U zcalc
function __calc_plugin {
    zcalc -e "$*"
}
aliases[=]='noglob __calc_plugin'

# zmv enables stuff like 'zmv *.jpg *.jpeg' to rename every jpg into jpeg
autoload -U zmv
alias zmv='noglob zmv'

# Prints ssh keys. Useful to check if new host has the right key
function print_keys () {
    echo "SSH keys:"
    for i in /etc/ssh/*.pub ; do
        ssh-keygen -l -f $i
    done
    echo "Root certs:"
    for i in /etc/letsencrypt/live/*/cert.pem ; do
        sudo openssl x509 -noout $i -in -fingerprint -sha1
    done
}

# Prints history statistics
function hist_stats () {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

# Basic utilities
alias _='sudo'
alias cleantex='rm *.{aux,idx,log,nav,out,snm,toc,vrb,bbl,blg}(.N) 2>/dev/null'
alias cp='cp  -i'
alias dd='dd status=progress'
alias gdb='gdb -q'
alias l='ls -lAh --color=auto'
alias ls='ls --color=auto'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias nrb='npm run build'
alias nrp='npm run pretty'
alias newsboat='rr record ~/prog/newsboat/newsboat'

# Grep
grepcmd='LC_ALL=C grep --color=auto --exclude-dir=build --exclude-dir=bin --exclude-dir=generated --exclude-dir=node_modules --exclude-dir=.svn --exclude-dir=.git --exclude-dir=.hg --exclude=package.json --exclude=package-lock.json --exclude=bundle.js.map --binary-files=without-match --line-number'
alias grep="$grepcmd"
alias gri="$grepcmd -ri"

# Git 
alias ga='git add'
alias gb='git branch'
alias gbb='git bisect bad'
alias gbg='git bisect good'
alias gbs='git bisect start'
alias gbr='git bisect reset'
alias gc='git commit --edit'
alias gch='git checkout'
alias gcl='git clone'
alias gd='git diff'
alias gf='git fetch -p'
alias glog='git log --first-parent --graph --abbrev-commit --decorate --date=relative --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\'' --all'
alias gm='git merge'
alias gmv='git mv'
alias gpu='git pull'
alias gr='git reset'
alias gre='git rebase'
alias grec='git rebase --continue'
alias grea='git rebase --abort'
alias grm='git rm'
alias gs='git show'

function gp {
    if [ $# -eq "0" ]; then
        git push -u
    else
        git push "$@"
    fi
}

# Fancy stuff
if [ -x "/usr/share/nvim/runtime/macros/less.sh" ] ; then
    alias less='/usr/share/nvim/runtime/macros/less.sh'
fi
gcc_alias='gcc -Wall -Wextra -Wlogical-op -Wjump-misses-init -Wshadow'
if [[ $(gcc -v 2>&1 | tail -1 | awk '{print $3}') > 6.0.0 ]] ; then
    gcc_alias="$gcc_alias -Wduplicated-cond -Wduplicated-branches -Wnull-dereference "
fi
alias gcc="$gcc_alias"

case "$(uname -a)" in
    *gentoo*) alias i="sudo emerge --ask";
              alias u="sudo emerge --unmerge";
              alias s="emerge --search";;
    *) alias i="sudo apt install";
       alias u="sudo apt remove";
       alias s="apt search";;
esac

