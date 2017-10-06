# cli pdf reader
function cpr () {
    pdftotext $1 - | less
}

# automatically change working dir of parent buffer if using zsh within nvim
function chpwd () {
    emulate -L zsh
    nvimcd "$(pwd)"
}

# dd wrapper to get that sweet sweet statusbar
function dd () {
    command dd status=progress "$@"
}

# Simple dc wrapper. $1 is input base, $2 is output base, $3 is value
function baseXtoY () {
    dc -e "${1}i${2}o${3}p"
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

# Simulates an http server using netcat.
# -d: display instead of downloading.
function httpserve () {
    download="attachment; "
    if [ "$1" = "-d" ]
    then
        download=""
        shift
    fi
    for i in "$@"
    do
        if [ ! -f "$i" ]
        then
            echo "No such file: $i"
            continue
        fi
        (echo -ne "HTTP/1.1 200 OK\r
Expires: -1\r
Server: Netcat :)\r
Content-Disposition: ${download}filename=\"$i\"\r
\r\n"; dd if="$i") | nc -l -p 8080 -q 1
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

alias _='sudo'
alias cleantex='rm *.{aux,idx,log,nav,out,snm,toc,vrb,bbl,blg}(.N) 2>/dev/null'
alias cp='cp  -i'
alias ea='nocorrect sudo emerge --ask'
alias ek='cd /usr/src/linux && sudo -s make menuconfig && sudo make -j5 && sudo make modules_install && sudo make install && sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias eq='nocorrect equery uses'
alias es='nocorrect emerge --search'
alias eu='nocorrect sudo emerge --unmerge'
alias ev='equery -q list --portage-tree'
alias ew='sudo emerge --ask --update --deep --changed-use @world && sudo emerge -av --depclean && sudo revdep-rebuild'
alias gdb='gdb -q'
alias glog='git log --graph --abbrev-commit --decorate --date=relative --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\'' --all'
alias grep='LC_ALL=C grep --color=auto --exclude-dir=.git --binary-files=without-match --line-number'
alias l='ls -lAh --color=auto'
alias ln='nocorrect ln'
alias ls='ls --color=auto'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias remoteshell='(term -e ssh -Y -tt x250 nvim term://zsh) &'
alias rtorrent='ssh -tt raspi abduco -A torrent rtorrent'
if [ -x "/usr/share/nvim/runtime/macros/less.sh" ] ; then
    alias less='/usr/share/nvim/runtime/macros/less.sh';
fi
