# Prompt and welcome message customization.
if test "$TERM" = "dumb" 
    exec sh
    exit
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
        printf "%s" "$(prompt_pwd --dir-length=5)"
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
function ls -w /usr/bin/ls -d "ls with some custom options."
    /usr/bin/ls -Alh --color=auto $argv
end

function grep -w /usr/bin/grep -d "grep with color."
    /usr/bin/grep --color=auto $argv
end

function kssh -w /usr/bin/ssh -d "ssh over kitten."
    kitten ssh $argv
end

# Environmental variables.
set -gx VISUAL nvim
set -gx XAPIAN_CJK_NGRAM 1

# Emacs vterm configuration.
# Placed in here because files from conf.d is read before this file,
# and the prompt defined in there will be overwritten.
set -l vterm_fish_location "$(status dirname)/emacs-vterm.fish"
if test "$INSIDE_EMACS" = "vterm"; and test -f "$vterm_fish_location"
    . "$vterm_fish_location"
end
