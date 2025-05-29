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

export PS1='\u@\h:\W> '
export PROMPT_COMMAND='printf "\e]133;A\007"'

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
    . ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh
fi
