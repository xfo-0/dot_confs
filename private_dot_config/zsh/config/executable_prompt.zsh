zmodload zsh/datetime
zmodload zsh/parameter
zmodload zsh/regex
zmodload zsh/zleparameter
zmodload zsh/zutil

autoload -Uz surround
autoload -Uz edit-command-line
zle -N edit-command-line
setopt VI
KEYTIMEOUT=8

znap source reegnz/jq-zsh-plugin
znap source hlissner/zsh-autopair
znap source ianthehenry/zsh-autoquoter
znap source zdharma-continuum/fast-syntax-highlighting

autoload -Uz colors && colors

zle_highlight=('paste:none')
typeset -g zle_highlight=(region:bg=235,fg=241)

setopt PROMPT_SUBST

zle-keymap-select() {
    case $KEYMAP in
        (vicmd|visual|isearch) printf '\e[2 q' ;; # Block cursor
        (main|.safe|emacs|viins) printf '\e[6 q' ;; # Beam cursor
        (*) [[ -n $1 ]] && printf '\e[6 q' ;; # Default to beam cursor if $1 is not empty
    esac
}

zle -N zle-keymap-select

znap eval starship "starship init zsh --print-full-init"
znap prompt
