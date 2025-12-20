# Prompt and welcome message customization.

if test "$TERM" = "dumb"
    function fish_prompt
        printf '$ '
    end

    function fish_greeting; end
else
    function fish_prompt
        set_color cyan
        printf "%s" "$USER"
        set_color normal

        printf " at "

        set_color green
        printf "%s" "$hostname"
        set_color normal

        printf " in "

        set_color blue
        printf "%s" "$(prompt_pwd --dir-length=8)"
        set_color normal

        printf "\n|-"

        set_color yellow
        printf "%s" "$(date +%H:%M)"
        set_color normal

        printf " "
    end

    function fish_greeting
        set_color blue
        printf ">"
        set_color green
        printf "<>"
        set_color normal

        printf " You're now at machine "

        set_color red
        printf "%s" "$hostname"
        set_color normal

        printf ". "

        set_color green
        printf "<>"
        set_color blue
        printf "<"
        set_color normal

        printf "\n"
    end
end

# Aliases.

function ls -w /bin/ls -d "ls with some custom options."
    /bin/ls -alh --color=auto $argv
end

# Bindings

bind ctrl-w backward-kill-token
bind alt-backspace backward-kill-word

# Environmental variables.

set -gx VISUAL nvim
set -gx EDITOR $VISUAL

# Emacs vterm configuration.
# Placed in here because files from conf.d is read before this file,
# and the prompt defined in there will be overwritten.

set -l vterm_fish_location "$(status dirname)/emacs-vterm.fish"
if test "$INSIDE_EMACS" = "vterm"; and test -f "$vterm_fish_location"
    . "$vterm_fish_location"
end
