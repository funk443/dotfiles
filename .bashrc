#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

unset HISTFILE

if [[ "$TERM" = "dumb" ]]; then
    set +o emacs vi
    export PS1='$ '
    return
fi

alias ls="/usr/bin/ls -alh --color=auto"
alias grep="/usr/bin/grep --color=auto"

export PS1='\h:\W> '

export XAPIAN_CJK_NGRAM=1
if test -z "$SSH_AUTH_SOCK"; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

export VISUAL=nvim

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
    source ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh
fi

. "${HOME}/.deno/env"
. "${HOME}/.local/share/bash-completion/completions/deno.bash"
