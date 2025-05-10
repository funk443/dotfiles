HISTFILE=
SAVEHIST=
HISTSIZE=1000

unsetopt beep
bindkey -e

zstyle :compinstall filename '/home/id/.zshrc'
autoload -Uz compinit
compinit

alias ls="/usr/bin/ls -alh --color=auto"
alias grep="/usr/bin/grep --color=auto"

export PS1="$(whoami) at $(hostname)> "
export VISUAL=nvim
export XAPIAN_CJK_NGRAM=1
