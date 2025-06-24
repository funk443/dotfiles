export PATH="${HOME}/.local/bin:${PATH}"

if [[ -d "${HOME}/.deno" ]]; then
    . "${HOME}/.deno/env"
    . "${HOME}/dotfiles/.local/share/bash-completion/completions/deno.bash"
fi

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

export VISUAL=nvim
export TERMINAL=alacritty

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

export XAPIAN_CJK_NGRAM=1

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

if [[ -f "${HOME}/.bashrc" ]]; then
    . "${HOME}/.bashrc"
fi
