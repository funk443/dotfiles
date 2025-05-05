# Prompt and welcome message customization.
if contains dumb "$TERM"
    function fish_prompt -d "Simpler prompt for dumb terminals."
        printf '$ '
    end

    function fish_greeting -d "Disable welcome message for dumb terminals."
    end
else
    function fish_prompt -d "ID's custom prompt."
        printf '%s%s%s at %s%s%s in %s%s%s\n|-%s%s%s ' \
            (set_color cyan)   "$USER"                        (set_color normal) \
            (set_color green)  "$hostname"                    (set_color normal) \
            (set_color blue)   "$(prompt_pwd --dir-length=5)" (set_color normal) \
            (set_color yellow) "$(date +%H:%M)"               (set_color normal)
    end

    function fish_greeting -d "ID's custom welcome message."
        printf "%s%s%s\n" (set_color brred) "urmom." (set_color normal)
    end
end

# Aliases.
function ls -w /usr/bin/ls -d "ls with some custom options."
    /usr/bin/ls -Alh --color=auto $argv
end

function grep -w /usr/bin/grep -d "grep with color."
    /usr/bin/grep --color=auto
end

function kssh -w /usr/bin/ssh -d "ssh over kitten."
    kitten ssh $argv
end

# Environmental variables.
set -gx VISUAL nvim

# Emacs vterm configuration.
# Placed in here because files from conf.d is read before this file,
# and the prompt defined in there will be overwritten.
if test "$INSIDE_EMACS" = "vterm"
    . "$(status dirname)"/emacs-vterm.fish
end
