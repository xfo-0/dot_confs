# NOTE:
# alt treated as esc.
# -s flag used to interpret escape sequence in command
# TODO:
# instead of a. o. .. back dir keybind, @, ~, -, /

# --------------------------------------------
# base {{{
# ___________________________________________________________________
bindkey '^l' clear-screen
bindkey '^s' autosuggest-accept
bindkey '^[a' expand_alias
bindkey '^[h' wrap_bhl
bindkey -s '^[s' 'sk_zi^M'
bindkey '^[r' skim-history
bindkey -s '^[g' 'sk_rg^M'
bindkey -s '^[f' 'fd --type f --no-ignore-vcs | sk^M'
# bindkey -s '^t' 'xr^M'
bindkey -s '^t' 'nnn^M'
bindkey '^[n' tere
bindkey '^[j' edit-command-line
bindkey -s '^[e' 'nvim^M'
bindkey '^j' jq-complete
# bindkey -s '^[m' 'newsboatM'

function leader_l() {
  local key
  local prompt="Leader l: "

  # Define the leader key bindings dictionary
  typeset -A key_l
  key_l=(
    ['n']='nvim -c "Neorg workspace notes"'
    ['e']="ls"
    ['s']="l"
    ['b']="btop"
    ['n']="nvtp"
  )

  # Construct the prompt string based on the dictionary
  for k in "${(@k)key_l}"; do
    prompt+="$k: ${key_l[$k]}, "
  done

  echo "leader l"
  echo -n "$prompt"
  read -k1 key
  echo

  # Execute the command associated with the key
  if [[ -n "${key_l[$key]}" ]]; then
    eval "${key_l[$key]}"
  else
    zle send-break
  fi
}

zle -N leader_l
bindkey "^[l" leader_l
# ___________________________________________________________________
# }}}
# --------------------------------------------
# Mode specific {{{
# ___________________________________________________________________
# Insert mode {{{
# 
bindkey '^[[P' delete-char
bindkey -M viins '^[[3~' delete-char
bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^[[F' end-of-line
bindkey -M viins '^[^[OH' beginning-of-line
bindkey -M viins '^[^[OF' end-of-line
# 
# }}}
# Normal Mode {{{
# 
bindkey -M vicmd '^[[3~' delete-char
bindkey -M vicmd '^[[H' beginning-of-line
bindkey -M vicmd '^[[F' end-of-line
bindkey -M vicmd '^[^[OH' beginning-of-line
bindkey -M vicmd '^[^[OF' end-of-line
# bindkey -M vicmd ' ' vi-easy-motion
bindkey -M vicmd 'cs' change-surround
bindkey -M vicmd 'ds' delete-surround
bindkey -M vicmd 'ys' add-surround
# 
# }}}
# Visual Mode {{{
# 
bindkey -M visual '^[[H' beginning-of-line
bindkey -M visual '^[[F' end-of-line
bindkey -M visual '^[^[OH' beginning-of-line
bindkey -M visual '^[^[OF' end-of-line
bindkey -M visual 'S' add-surround
foreach char ({a,i}{\',\",\`}) { bindkey -M visual $char select-quoted } && unset char # Text objects for delimiters.
foreach char ({a,i}${(s..)^:-'()[]{}<>bB'}) { bindkey -M visual $char select-bracketed } && unset char # Text objects for pairs of brackets.
# 
# }}}
# Operator Mode {{{
# 
bindkey -M viopp '^[[H' vi-beginning-of-line
bindkey -M viopp '^[[F' vi-end-of-line
bindkey -M viopp '^[^[OH' beginning-of-line
bindkey -M viopp '^[^[OF' end-of-line
foreach char ({a,i}{\',\",\`}) { bindkey -M viopp $char select-quoted } && unset char # Text objects for delimiters.
foreach char ({a,i}${(s..)^:-'()[]{}<>bB'}) { bindkey -M viopp $char select-bracketed } && unset char # Text objects for pairs of brackets.
# 
# }}}
# tmux escapes  {{{
# 
# bindkey '\E[1~' beginning-of-line
# bindkey '\E[4~' end-of-line

bindkey -M vicmd '\E[3~' delete-char
bindkey -M vicmd '\E[1~' beginning-of-line
bindkey -M vicmd '\E[4~' end-of-line
bindkey -M vicmd '^[^[OH' beginning-of-line
bindkey -M vicmd '^[^[OF' end-of-line

bindkey -M viins '\E[3~' delete-char
bindkey -M viins '\E[1~' beginning-of-line
bindkey -M viins '\E[4~' end-of-line
bindkey -M viins '^[^[OH' beginning-of-line
bindkey -M viins '^[^[OF' end-of-line
# 
# }}}
# ___________________________________________________________________
# }}}
# --------------------------------------------
