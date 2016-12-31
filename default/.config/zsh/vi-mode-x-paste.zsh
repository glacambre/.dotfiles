if [ $(which "xsel") ] ; then
    bindkey -M vicmd -r '"'
    vi-x-paste-set-buffer () {
        if [ ${REGION_ACTIVE} -eq 1 ]; then
            zle kill-region;
        fi
        RBUFFER="$1$RBUFFER";
        YANK_START=$CURSOR;
        CURSOR=$(($CURSOR+${#1}));
        YANK_END=$CURSOR;
    }
    vi-x-paste-primary () {
        vi-x-paste-set-buffer "$(xsel -o -p </dev/null)" ;
    }
    vi-x-paste-primary-before () {
        vi-x-paste-primary;
    }
    vi-x-paste-primary-after () {
        if [ ${REGION_ACTIVE} -eq 0 ]; then
            CURSOR=$(($CURSOR+1));
        fi
        vi-x-paste-primary;
    }
    vi-x-paste-clipboard () {
        vi-x-paste-set-buffer "$(xsel -o -b </dev/null)" ;
    }
    vi-x-paste-clipboard-before () {
        vi-x-paste-clipboard;
    }
    vi-x-paste-clipboard-after () {
        if [ ${REGION_ACTIVE} -eq 0 ]; then
            CURSOR=$(($CURSOR+1));
        fi
        vi-x-paste-clipboard;
    }
    vi-x-copy-to-clipboard () {
        if [ ${REGION_ACTIVE} -eq 0 ]; then
            if [ $CURSOR -lt $MARK ]; then
                echo "${BUFFER[$(($CURSOR+1)),$(($MARK+1))]}" | xsel --clipboard;
            else
                echo "${BUFFER[$(($MARK+1)),$(($CURSOR+1))]}" | xsel --clipboard;
            fi
        fi
    }
    zle -N vi-x-paste-primary-after
    zle -N vi-x-paste-primary-before
    zle -N vi-x-paste-clipboard-after
    zle -N vi-x-paste-clipboard-before
    zle -N vi-x-copy-to-clipboard
    bindkey -M vicmd '"*p' vi-x-paste-primary-after
    bindkey -M vicmd '"*P' vi-x-paste-primary-before
    bindkey -M vicmd '"+p' vi-x-paste-clipboard-after
    bindkey -M vicmd '"+P' vi-x-paste-clipboard-before
    bindkey -M vicmd '"+y' vi-x-copy-to-clipboard
fi
