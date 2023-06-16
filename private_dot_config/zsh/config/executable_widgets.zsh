znap eval zoxide "zoxide init zsh"

sk-zi() {
    local selected_dir
    selected_dir=$(sk --ansi -i --keep-right --cycle --exact --no-sort --inline-info --tabstop=1 --layout=reverse --select-1 --exit-0 --preview-window=down:40% --preview='exa -F --icons -a -s=type {1..}' -c 'zoxide query -l "{}"') || return
    # echo -n "$selected_dir"
    z "$selected_dir"
}

skimcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${SKIM_TMUX:-0}" != 0 ] || [ -n "$SKIM_TMUX_OPTS" ]; } &&
    echo "sk-tmux ${SKIM_TMUX_OPTS:--d${SKIM_TMUX_HEIGHT:-40%}} -- " || echo "sk"
}

sk-history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} $SKIM_DEFAULT_OPTIONS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $SKIM_CTRL_R_OPTS --query=${(qqq)LBUFFER} --no-multi" $(skimcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

rga-sk() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		SK_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			sk --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				 -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

bh() {
    "$@" -h 2>&1 | bat --plain --language=help
}

wrap-bh() {
    BUFFER="bh $BUFFER"
    zle accept-line
}

bhl() {
    "$@" --help 2>&1 | bat --plain --language=help
}

wrap-bhl() {
    BUFFER="bhl $BUFFER"
    zle accept-line
}

expand-alias() {
    BUFFER="alias $BUFFER"
    zle accept-line
}


# vmc() {
#   items=("default" "nvim2phi" "lunarvim" "nvchad" "astronvim")
#   config=$(printf "%s\n" "${items[@]}" | sk --prompt=" Neovim Config  " --layout=reverse --border --exit-0)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   elif [[ $config == "default" ]]; then
#     config=""
#   fi
#   NVIM_APPNAME=$config /usr/local/bin/nvim $@
# }

# Register functions as widgets.
foreach widget (
    'add-surround surround'
    'delete-surround surround'
    'change-surround surround'
    select-quoted
    select-bracketed
    sk-zi
    sk-history
    rga-sk
    bh
    wrap-bh
    bhl
    wrap-bhl
    expand-alias
    jq-complete
    edit-command-line
    ) {
    eval zle -N $widget
}

unset widget
