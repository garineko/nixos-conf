if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

starship init fish | source
zoxide   init fish | source

alias du="dust"
alias cat="bat"
alias top="btm"
alias cd="z"
alias ls="exa"
alias tree="exa --tree"
alias ps="procs"
alias df="duf"

function fish_greeting
    neofetch
end