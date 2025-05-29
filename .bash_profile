if [[ -d "${HOME}/.deno" ]]; then
    . "${HOME}/.deno/env"
    . "${HOME}/dotfiles/.local/share/bash-completion/completions/deno.bash"
fi

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

export VISUAL=nvim

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

export XAPIAN_CJK_NGRAM=1
