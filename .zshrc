HISTFILE=
SAVEHIST=
HISTSIZE=1000

unsetopt beep
bindkey -e

zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

alias ls="/usr/bin/ls -alh --color=auto"
alias grep="/usr/bin/grep --color=auto"

export PROMPT="%M:%1~> "
export VISUAL=nvim
export XAPIAN_CJK_NGRAM=1

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
	source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
fi
