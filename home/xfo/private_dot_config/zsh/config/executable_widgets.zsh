# Register functions as widgets.
foreach widget (
    'add-surround surround'
    'delete-surround surround'
    'change-surround surround'
    select-quoted
    select-bracketed
    # user-fuzzy-history
    # user-fuzzy-select
    ) {
    eval zle -N $widget
}
unset widget

fzf-lolcate-widget() {
    local selected
    if selected=$(lolcate / | fzf -q "$LBUFFER"); then
        LBUFFER=$selected
    fi
    zle redisplay
}
# FIX: fzf bindkey keymap viewer  {{{


# mmez () {
#     choice=(
#         $(
#             mamba env list |
#             sed 's/\*/ /;1,2d' |
#             xargs -I {} bash -c '
#                 name_path=( {} );
#                 py_version=( $(${name_path[1]}/bin/python --version) );
#                 echo ${name_path[0]} ${py_version[1]} ${name_path[1]}
#             ' |
#             column -t |
#             sk --layout reverse \
#                 --inline-info \
#                 --border \
#                 --height 40 \
#                 --preview-window "right:30%" \
#                 --header " conda tree leaves " \
#                 --preview $'
#             mamba tree -p {3} leaves |
#             perl -F\'[^\\w-_]\' -lae \'print for grep /./, @F;\' |
#             sort
#             '
#         )
#     )
#     [[ -n "$choice" ]] && conda activate "$choice"
# }
# zle -N mmez

# }}}
# aur {{{
# Install packages using paru (change to pacman/AUR helper of your choice)
# NOTE: -Sl could be used showing version and core/extra/community/aur
#       would need to add syntax highlighting for selections and have function for --preview string

# function ausz() {
#     paru -Sl | fzf -q "$1" -m --preview 'paru -Si {1}'| xargs -ro paru -S
# }
# # Remove installed packages (change to pacman/AUR helper of your choice)
# function aurm() {
#     paru -Qq | fzf -q "$1" -m --preview 'paru -Qi {1}' | xargs -ro paru -Rns
# }

# # Helper function to integrate paru and fzf
# auz () {
#   pos=$1
#   shift
#   sed "s/ /\t/g" |
#     sk --nth=$pos --multi --history="${SKIM_HISTDIR:-$XDG_STATE_HOME/skim}/history-yzf$pos" \
#       --preview-window=60%,border-left \
#       --bind="double-click:execute(xdg-open 'https://archlinux.org/packages/{$pos}'),alt-enter:execute(xdg-open 'https://aur.archlinux.org/packages?K={$pos}&SB=p&SO=d&PP=100')" \
#        "$@" | cut -f$pos | xargs
# }

# zle -N auz

# # Dev note: print -s adds a shell history entry
# #
# # List installable packages into fzf and install selection
# ausz () {
#   cache_dir="/tmp/yas-$USER"
#   test "$1" = "-y" && rm -rf "$cache_dir" && shift
#   mkdir -p "$cache_dir"
#   preview_cache="$cache_dir/preview_{2}"
#   list_cache="$cache_dir/list"
#   { test "$(cat "$list_cache$@" | wc -l)" -lt 50000 && rm "$list_cache$@"; } 2>/dev/null
#   pkg=$( (cat "$list_cache$@" 2>/dev/null || { pacman --color=always -Sl "$@"; paru --color=always -Sl aur "$@" } | sed 's/ [^ ]*unknown-version[^ ]*//' | tee "$list_cache$@") |
#     yzf 2 --tiebreak=index --preview="cat $preview_cache 2>/dev/null | grep -v 'Querying' | grep . || paru --color always -Si {2} | tee $preview_cache")
#   if test -n "$pkg"
#     then echo "Installing $pkg..."
#       cmd="paru -S $pkg"
#       print -s "$cmd"
#       eval "$cmd"
#       rehash
#   fi
# }
# zle -N ausz
# # List installed packages into fzf and remove selection
# # Tip: use -e to list only explicitly installed packages
# aurz () {
#   pkg=$(paru --color=always -Q "$@" | yzf 1 --tiebreak=length --preview="paru --color always -Qli {1}")
#   if test -n "$pkg"
#     then echo "Removing $pkg..."
#       cmd="paru -R --cascade --recursive $pkg"
#       print -s "$cmd"
#       eval "$cmd"
#   fi
# }
# zle -N aurz

# # Define the widget
# function view-keymap-bindings() {
#     # Get the list of keymaps
#     # use bindkey -l
#     keymaps=("${(@f)$(bindkey -l)}")
#
#     # Select one of the keymaps using fzf
#     local selected_keymap=$(echo "${keymaps[@]}" | fzf)
#
#     # Show the bindings for the selected keymap
#     bindkey -M $selected_keymap
# }
#
# # Bind the widget to a key
# zle -N view-keymap-bindings
# bindkey '^k' view-keymap-bindings
# # }}}

# zle     -N    fzf-locate-widget
# bindkey '\ei' fzf-locate-widget

# # Select command from history into the command line.
# function user-fuzzy-history() {
#   if ! (( $+commands[fzf] )) {
#     return 1
#   }
#
#   setopt LOCAL_OPTIONS NO_GLOB_SUBST NO_POSIX_BUILTINS PIPE_FAIL 2>/dev/null
#
#   local selected=($(
#     fc -l 1 \
    #     | fzf \
    #       --tac \
    #       --nth='2..,..' \
    #       --tiebreak='index' \
    #       --query="${LBUFFER}" \
    #       --exact
#   ))
#
#   local stat=$?
#
#   if [[ "$selected" != '' ]] {
#     local num=$selected[1]
#
#     if [[ "$num" != '' ]] {
#       zle vi-fetch-history -n $num
#     }
#   }
#
#   zle reset-prompt
#   return $stat
# }
#
# # Paste the selected file or directory into the command-line.
# function user-fuzzy-select() {
#   if ! (( $+commands[fzf] )) {
#     return 1
#   }
#
#   local directory=${${(ps: :)LBUFFER}[-1]}
#   (! [[ -d "$directory" ]]) && unset directory
#
#   local selected=$(
#     find -L ${directory:-'.'} \
    #       \( \
    #         -fstype 'dev' \
    #         -or -fstype 'proc' \
    #         -or \( -type d -name 'node_modules' -or -type d -name '.git' \) \
    #       \) -prune \
    #       -or \( -type 'd' -printf '%p/\n' , -type 'f' -print \) 2>/dev/null \
    #     | sed 1d \
    #     | ([[ -v directory ]] && cat || cut --bytes=3-) \
    #     | fzf \
    #       --preview-window='right:60%' \
    #       --preview=' \
    #         if [ -d {} ]; then; \
    #           ls -l --si --almost-all --classify --color=always --group-directories-first --literal {} 2>/dev/null; \
    #         else \
    #           cat {} 2>/dev/null; \
    #         fi \
    #       ' \
    #   )
#
#   if [[ "$selected" != '' ]] {
#     LBUFFER="${LBUFFER//${directory:-}/}${selected}"
#   }
#
#   zle reset-prompt
# }
#  }
