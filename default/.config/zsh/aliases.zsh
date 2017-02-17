function cpr () {
    pdftotext $1 - | less
}

function dd () {
    command dd status=progress $@
}

function go () {
    if [[ "$GOPATH" != "" ]]; then;
        command go $@;
        return;
    fi
    local dir="$PWD"
    for i in 0 1 2 3; do
        if [ -d "$dir/.gopath" ]; then;
            GOPATH="$dir/.gopath" command go $@;
            return;
        fi
        dir="$dir/../";
    done
    if [ ! -e "$PWD/.gopath" ]; then;
        mkdir .gopath;
    fi
    GOPATH="$PWD/.gopath" command go $@;
    return;
}

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

function hist_stats () {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

alias _='sudo'
alias cp='cp  -i'
alias mv='nocorrect mv -i'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias cleantex='rm *.{aux,idx,log,nav,out,snm,toc,vrb}(.N) 2>/dev/null'
alias ea='nocorrect sudo emerge --ask'
alias ek='cd /usr/src/linux && sudo -s make menuconfig && sudo make && sudo make modules_install && sudo make install'
alias eq='nocorrect equery uses'
alias es='nocorrect emerge --search'
alias eu='nocorrect sudo emerge --unmerge'
alias ev='equery -q list --portage-tree'
alias ew='sudo emerge --ask --update --deep --changed-use @world && sudo emerge -av --depclean && sudo revdep-rebuild'
alias grep='LC_ALL=C grep --color=auto --exclude-dir=.git --binary-files=without-match --line-number'
alias glog='git log --graph --abbrev-commit --decorate --date=relative --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\'' --all'
alias l='ls -lAh --color=auto'
alias ls='ls --color=auto'
alias rtorrent='ssh -tt raspi abduco -A torrent rtorrent'
alias remoteshell='(term -e ssh -Y -tt x250 nvim term://zsh) &'
if [ -x "/usr/share/nvim/runtime/macros/less.sh" ] ; then
    alias less='/usr/share/nvim/runtime/macros/less.sh';
fi
