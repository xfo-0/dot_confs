# cd on exit
function n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

skim-history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} $SKIM_DEFAULT_OPTIONS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $SKIM_CTRL_R_OPTS --query=${(qqq)LBUFFER} --no-multi" $(__skimcmd)) )
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
zle -N skim-history

bh() {
    "$@" -h 2>&1 | bat --plain --language=help
}
wrap_bh() {
    BUFFER="bh $BUFFER"
    zle accept-line
}
zle -N wrap_bh

bhl() {
    "$@" --help 2>&1 | bat --plain --language=help
}
wrap_bhl() {
    BUFFER="bhl $BUFFER"
    zle accept-line
}
zle -N wrap_bhl

expand_alias() {
    BUFFER="alias $BUFFER"
    zle accept-line
}
zle -N expand_alias

tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}
zle -N tere

sk_zi() {
    local selected_dir
    selected_dir=$(sk --ansi -i --keep-right --cycle --exact --no-sort --inline-info --tabstop=1 --layout=reverse --select-1 --exit-0 --preview-window=down:40% --preview='exa -F --icons -a -s=type {1..}' -c 'zoxide query -l "{}"') || return
    # echo -n "$selected_dir"
    z "$selected_dir"
}
zle -N sk_zi

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
zle -N rga-sk

vmc() {
  items=("default" "nvim2phi" "lunarvim" "nvchad" "astronvim")
  config=$(printf "%s\n" "${items[@]}" | sk --prompt=" Neovim Config  " --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config /usr/local/bin/nvim $@
}
zle -N vmsw

# bindkey -s ^a "nvims\n"
