# Plugins
plug "mafredri/zsh-async"
plug "djui/alias-tips"
plug "hlissner/zsh-autopair"
plug "ianthehenry/zsh-autoquoter"

plug "kutsan/zsh-system-clipboard" # {{{
typeset -g ZSH_SYSTEM_CLIPBOARD_METHOD='wlc'
# }}}

#zsh autocomplete # {{{
zstyle ':autocomplete:recent-dirs' backend zoxide
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' widget-style menu-select
plug "marlonrichert/zsh-autocomplete"
# }}}

plug "zsh-users/zsh-autosuggestions" # {{{
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#474747,bold,underline"
typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='20'
typeset -g ZSH_AUTOSUGGEST_ASYNC_PTY_NAME='zsh_autosuggest_pty'
typeset -ga ZSH_AUTOSUGGEST_STRATEGY=('history')
typeset -ga ZSH_AUTOSUGGEST_EXECUTE_WIDGETS=()
typeset -ga ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
    history-search-forward
    history-search-backward
    history-beginning-search-forward
    history-beginning-search-backward
    history-substring-search-up
    history-substring-search-down
    up-line-or-beginning-search
    down-line-or-beginning-search
    up-line-or-history
    down-line-or-history
    accept-line
)
typeset -ga ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    vi-forward-char
)
typeset -ga ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    vi-forward-word
)
typeset -ga ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(
    orig-\*
    beep
    run-help
    set-local-history
    which-command
    yank
    yank-pop
)
# }}}

plug "zdharma-continuum/fast-syntax-highlighting" # {{{
# FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}unknown-token]='fg=red'
# }}}

plug "wfxr/forgit"
plug "reegnz/jq-zsh-plugin"
# }}}
