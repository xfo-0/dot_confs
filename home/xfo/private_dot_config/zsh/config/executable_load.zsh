# Make special variables duplicate-free.
typeset -gU path fpath cdpath

# Define functions to load them on execution.
foreach function (
    colors
    add-zsh-hook
    compinit
    bashcompinit
    surround
    edit-command-line
    promptinit
    select-bracketed
    select-quoted
    vcs_info
    zrecompile
    ) {
    autoload -U $function
}

# Load binary modules.
foreach module (
    complete
    complist
    datetime
    parameter
    regex
    zle
    zleparameter
    zpty
    zutil
    ) {
    zmodload zsh/$module
}

_comp_options+=(globdots)		# Include hidden files.
fpath=( "$ZDOTDIR/completion" $fpath )
# Initialize the completion system with a cache time of 24 hours.
typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"
typeset -g comp_files=($zcompdump(Nm-24))

if (( $#comp_files )) {
    compinit -i -C -d $zcompdump
    } else {
    compinit -i -d $zcompdump
}

unset zcompdump
unset comp_files

zle -N edit-command-line

eval "$(zoxide init zsh)"
# eval "$(luarocks path --lua-version 5.4)"
if ! env | grep -q SSH_AUTH_SOCK ; then
  eval "$(ssh-agent -s)" > /dev/null
fi

if [[ ! -f ~/git/system/term/zsh/zsh-snap/znap.zsh ]]; then
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/git/system/term/zsh/zsh-snap/
fi



foreach file (
    ~/git/system/term/zsh/zsh-snap/znap.zsh
    ~/.profile
    # ~/.local/share/zap/zap.zsh
    /usr/share/fzf/completion.zsh
    /usr/share/fzf/key-bindings.zsh
    /usr/share/doc/git-extras/git-extras-completion.zsh
    # /usr/share/nvm/init-nvm.sh
    ) {
    [[ -f $file ]] && source $file
}
unset file

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if [[ "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .name')" != "\"nnn_preview_float\"" && "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .name')" != "\"term_pick\"" && "$TERM_PROGRAM" != "tmux" ]]; then
    if [[ $(tmux list-sessions | wc -l) -eq 0 ]]; then
        tmux new-session -d -s "launch"
        tmux new-session -s "1"
        tmux send-keys -t "1:1" "C-l"
    elif [[ $(tmux list-sessions | wc -l) -eq 1 ]]; then
        if [[ $(tmux has-session -t "launch") ]]; then
            tmux new-session -s "1"
            tmux send-keys -t "1:1" "C-l"
        else
            tmux new-session -d -s "launch"
        fi
    elif [[ $(tmux list-sessions | wc -l) -ge 2 ]]; then
        tmux new-session -s "$(tmux list-sessions | wc -l)"
        tmux send-keys -t "$(tmux list-sessions | wc -l):1" "C-l"
    fi
elif [[ "$TERM_PROGRAM" == "tmux" ]]; then
    # if [[ $(tmux list-sessions | wc -l) -ge 2 ]]; then
    #     attached_session=$(tmux display-message -p \#S >2&1)
    #     window_count=$(( $(tmux list-windows -t "$(attached_session)" | wc -l) + 1 ))
    #     tmux new-window
    #     tmux send-keys -t "$(attached_session):$((window_count - 1))" "C-l"
    # fi
fi

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# for use with micromamba
# # >>> mamba initialize >>>
# # !! Contents within this block are managed by 'mamba init' !!
# export MAMBA_EXE="/home/xfo/bin/micromamba";
# export MAMBA_ROOT_PREFIX="/home/xfo/micromamba";
# __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__mamba_setup"
# else
#     if [ -f "/home/xfo/micromamba/etc/profile.d/micromamba.sh" ]; then
#         . "/home/xfo/micromamba/etc/profile.d/micromamba.sh"
#     else
#         export  PATH="/home/xfo/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
#     fi
# fi
# unset __mamba_setup
# # <<< mamba initialize <<<

# [[ -z $TMUX ]] || micromamba deactivate; micromamba activate base

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/xfo/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/xfo/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/xfo/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/xfo/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/xfo/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/xfo/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# [[ -z $TMUX ]] || mamba deactivate; mamba activate base


# for use with conda
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
#         . "/opt/anaconda/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/anaconda/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# export LD_LIBRARY_PATH="${CONDA_PREFIX}/lib/:$LD_LIBRARY_PATH"

# [[ -z $TMUX ]] || conda deactivate; conda activate base
