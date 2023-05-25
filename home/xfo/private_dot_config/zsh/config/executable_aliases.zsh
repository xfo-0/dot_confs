# TODO:
# direct alt/ctrl based tree/leader style bindings?

alias pcp='| ${COPY_CMD}'
alias prg='| rg '

# --------------------------------------------

# edit defaults/sourcing  {{{

alias sdo='sudo '

alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME"/yarn/config'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias mbsync='mbsync -c "$XDG_CONFIG_HOME"/isync/mbsyncrc'
alias abook='abook --config "$XDG_CONFIG_HOME"/abook/abookrc --datafile "$XDG_DATA_HOME"/abook/addressbook'
alias tldr="/usr/local/bin/tldr"

#  }}}

# --------------------------------------------

# disk  {{{

# drives  {{{

alias free='free -m' # show sizes in MB
alias dst='dust '
alias df='duf '
alias dskn='diskonaut '
alias brt='broot '
alias fdk='sudo fdisk '
alias fdl='sudo fdisk -l '

alias gdk='sudo gdisk '
alias lbk='sudo lsblk '

#  }}}

# file/path  {{{

# find  {{{

# fd  {{{

# alias fdx='fd -x '

#  }}}

# grep  {{{

alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias fgrep='fgrep --color=auto '

#  }}}

# rg  {{{

# rga for pdf, jpg, subtitles, etc
# bingrep for binary
# alias rgx='rg -x '

#  }}}

# fzf  {{{

alias fz='fzf '
# alias fzp='bat --color=always --style=numbers --line-range=:500 {}'

#  }}}

# sk  {{{

# TODO: sk color
#       sk aliases
# alias skc='sk --color=fg:#cccccc,bg:#000000,hl:#403933,matched_bg:#1c1c1c,fg+:#e0e0e0,bg+:#2e2e2e,hl+:#3e3a3a,current_match_bg:#bf7c13,query:#777d69,query_bg:#bfb0a2,info:#FFFFFF,border:#d78700,prompt:#FFFFFF,cursor:#FFFFFF,marker:#FFFFFF,spinner:#FFFFFF,header:#FFFFFF'
#

#  }}}

# lolcate {{{

# ___________________________________________________________________
alias lc='lolcate '
alias lcd='lolcate --db '
alias lcu='lolcate --update '
alias lcud='lolcate --update --db '
alias lcua='lolcate --update --all '
alias lcb='lolcate --basename '
alias lct='lolcate --type '
alias lci='lolcate --info '
# ___________________________________________________________________

#  }}}

#  }}}

# pre/view  {{{

alias l='exa -l -a -s=type --inode -g --git --icons --octal-permissions ' # colorize the ls output
alias ls='exa -F --icons -a -s=type ' # use a long listing format
alias lt="tree --filelimit "$(find . -maxdepth 1 | wc -l)" -L 3 -C -F --dirsfirst --noreport"

alias pue='pueue ' # long running task execution management

alias tk='tokei '

alias epth='echo -e ${PATH//:/\\n}'
alias ali='alias '
alias alz='alias | ${FZ_PICKER}'

alias chs="cht.sh "


alias tl="/usr/bin/tldr "
alias tlu="tl --update && tldr --update"

alias ni='navi ' # command summary/overview tui
alias nic='navi --cheatsh ' # command summary/overview
alias nit='navi --tldr ' # command summary/overview

alias bt='bat '
alias zth='zathura '
alias dlt='delta '
# ddh: finding duplicate files
# lso czkawka for more extensive unnecessary file removal
alias mn='man -P bat '
alias bathelp='bat --plain --language=help'
alias pbt='| bat '
# functions.zsh: bh bhl usage

#  }}}

# edit  {{{

alias vm='/usr/local/bin/nvim '
alias vn='nvim ~/notes/index.norg '
alias pvm='| vm '

alias xr='/usr/bin/xplr '
alias nnn='n -HEUGdixroe '

alias wex='watchexec ' # watch for path modifications and execute

# compression  {{{

alias ou='ouch'
alias oud='ouch decompress '
alias ouc='ouch compress '
alias oul='ouch list '

# }}}

# nav  {{{

alias a.='cd ..'
alias o.='cd ../../'
alias e.='cd ../../../'
alias u.='cd ../../../../'
alias i.='cd ../../../../..'
alias cdp='cd $(${PASTE_CMD})'
alias pwdpc='pwd | ${COPY_CMD}'

# zoxide  {{{

# alias zq='zoxide query'
# alias zqc='zoxide query $1 | ${COPY_CMD}'

#  }}}


#  }}}

# cp/ln  {{{

alias dbs="dotbot -d "${DOTBOT_DIR}" -c "${DOTBOT_CONF}" -p "${DOTBOT_DIR}/dotbot-gitcrypt/gitcrypt.py" "${@}""

# alias cp='/usr/local/bin/advcp -g -i -v'
alias cp='xcp -v '
alias scp='sudo xcp -v '
alias cpr='xcp -r -v'
# alias cpl='/usr/local/bin/advcp -s -v'

alias lnr="ln -sfn "

alias dgd='dragon-drop '

#  }}}

# mv/mk  {{{

alias mv='/usr/local/bin/advmv -i -v'
alias smv='sudo /usr/local/bin/advmv -i -v'
alias mvg='/usr/local/bin/advmv -g -v'
mkc ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
     }
alias mk='mkdir -p '
alias smk='sudo mkdir '
# alias ddx='dd '

#  }}}

# rm/trash/y  {{{

alias rmr='rm -r '
alias rmr='rm -r '
alias srmr='sudo rm -r '
alias srmr='sudo rm -r '

alias tr='trash '
alias trash-cli='trash '
alias trash-put='trash put '
alias trl='trash list'
alias trrz="trash list | ${FZ_PICKER} --multi | awk '{print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force"
alias tre='trash empty'
alias trez="trash list | ${FZ_PICKER} --multi | awk '{print}' | rev | cut -d ' ' -f1 | rev | xargs trash empty --match=exact --force"

#  }}}

# contents  {{{

# alias sed
# sd # intuitive find and replace cli, alternative to sed
alias srt='sort '
# hck # rougher form of cut
alias chs='choose ' # cut alternative, sometimes awk
alias rgs='rargs ' # xargs/awk pattern matching util
# alias frawk # awk alternative


#  }}}

#  }}}

#  }}}

#  }}}

# --------------------------------------------

# process management  {{{

alias scu="systemctl --user "
alias scus="systemctl --user start "
alias scux="systemctl --user stop "
alias scure="systemctl --user restart "
alias scust="systemctl --user status "
alias scudre="systemctl --user daemon-reload "

alias sculse="systemctl --user --type=service --state=enabled"
alias sculne="systemctl --user list-unit-files --state=enabled"

alias sc="sdo systemctl "
alias scs="sdo systemctl start "
alias scx="sdo systemctl stop "
alias scre="sdo systemctl restart "
alias scst="sdo systemctl status "
alias scdre="sdo systemctl daemon-reload "

alias sclse="sdo systemctl --type=service --state=enabled"
alias sclne="sdo systemctl list-unit-files --state=enabled"

alias rwh='sdo pkill -HUP swhkd' # reload sxhkd config

alias hlr='handlr '

alias trp='trap -p '
alias trpl="kill -l | while read -r line; do printf ' %2s) SIG%s' $line $line; done | xargs printf '%-15s %-15s %-15s %s\n'"

alias hpr='hyperfine '
alias nvtp="pipx run nvitop "
alias btp="btop "
alias kn='kmon ' # linux kernel monitor
alias soid='systeroid ' # sysctl alternative
alias soidt='systeroid-tui'
alias byth='bythound ' # system memory profiler


# tmux  {{{

# TODO: add xargs type command for piping into tmux send keys to preserve zsh completion
alias tm='tmux '
alias tma='tmux attach -t '
alias tmd='tmux detach '
alias tmad='tmux attach -d -t '
alias tms='tmux new-session -s '
alias tml='tmux list-sessions '
alias tmksv='tmux kill-server '
alias tmks='tmux kill-session -t '

#  }}}


# docker  {{{

alias dk='docker '
alias dkr='docker run '
alias dkcr='docker-compose run '
alias dkcup='docker-compose up '
alias dkps='docker ps '
alias dkst='docker stop '
alias dkk='docker kill '
alias dkcp='docker cp '
alias dkex='docker exec -it '
alias dkrn='docker rename '
alias dkcom='docker commit '
alias dkpsa='docker ps -a '
alias dkcps='docker-compose ps '
alias dkcplg='docker-compose logs '
alias dkpl='docker pull '
alias dkcpl='docker-compose pull '
alias dkpu='docker push '
alias dkim='docker image '
alias dkims='docker images '
alias dkb='docker build '
alias dkc='docker compose '
alias dkrm='docker rm '
alias dkrmi='docker rmi '
alias ndk='docker --gpus all '
alias ndkr='docker run --gpus all '
alias ndkcr='docker-compose --gpus all run '
alias ndkcup='docker-compose --gpus all up '
alias ndkps='docker ps --gpus all '
alias ndkst='docker stop --gpus all '
alias ndkk='docker kill --gpus all '
alias ndkcp='docker cp --gpus all '
alias ndkex='docker exec -it --gpus all '
alias ndkrn='docker rename --gpus all '
alias ndkcom='docker commit --gpus all '
alias ndkpsa='docker ps -a --gpus all '
alias ndkcps='nvidia-docker-compose ps '
alias ndkcplg='nvidia-docker-compose logs '
alias ndkpl='docker pull --gpus all '
alias ndkcpl='nvidia-docker-compose pull '
alias ndkpu='docker push --gpus all '
alias ndkim='docker image --gpus all '
alias ndkims='docker images --gpus all '
alias ndkb='docker build --gpus all '
alias ndkc='docker compose --gpus all '
alias ndkrm='docker rm --gpus all '
alias ndkrmi='docker rmi --gpus all '
alias dkfq='docker-compose -f trade.yml run --rm freqtrade '
alias dkfqtrade='docker-compose -f trade.yml up -d '
alias dkfqd='docker-compose run --rm freqtrade download-data '
alias dkfqb='docker-compose run --rm freqtrade backtesting --config '

#  }}}


#  }}}

# --------------------------------------------

# network/peripherals  {{{

alias trp='trip '
alias bndw='bandwhich '

# blokator  {{{

#
alias bka='blokator '
alias bkac='blokator -s '
alias bkaa='blokator -a '
alias bkal='blnokator -l '

#  }}}

# newsboat {{{

alias nb='newsboat '
alias nbp='${PASTE_CMD} >> ~/.config/newsboat/urls '

# }}}

# neomutt {{{

alias nm='neomutt '

# }}}

# ssh  {{{

alias pn="gping "

#  }}}

# mullvad {{{

alias mlv='mullvad '
alias mlx='mullvad-exclude '
alias mlst='mullvad status -v '
alias mlc='mullvad connect '
alias mld='mullvad disconnect '
alias mlr='mullvad reconnect '
alias mlt='mullvad relay '

#}}}

# kdeconnect  {{{

alias kdc='kdeconnect-cli '
alias kdh='kdeconnect-handlr '

#  }}}

# lifx  {{{

alias lx='lifx  '

#  }}}

# lg webos  {{{

alias lgt="webostv "
alias lgx="webostv power off $LOCAL_LG_ADR $LOCAL_LG "
alias lgo="webostv power on $LOCAL_LG_ADR $LOCAL_LG "

#  }}}

# qmk  {{{

# alias qmjc='qmk c2json -km base -kb kbdfans/kbd67/mkiirgb/v2 ~/qmk_firmware/keyboards/kbdfans/kbd67/mkiirgb/keymaps/base/keymap.c '
alias qmc='qmk compile -kb kbdfans/kbd67/mkiirgb/v2 -km '
alias qmf='qmk flash -kb kbdfans/kbd67/mkiirgb/v2 -km '

#  }}}

# bluetooth  {{{

#

#  }}}

#  }}}

# --------------------------------------------

# lang  {{{

# jupyter   {{{

alias jpk='python -m ipykernel install --user --name='
alias jpmkp='python -m jupyter_ascending.scripts.make_pair --base '
alias jpn='jupyter notebook '
alias jpl='jupyter lab '

#  }}}

# python  {{{

alias pyt='python '
alias pyp='pypy '
alias jd='johnnydep '
# TODO: xargs for using different chat session aliases w/ commands (no localized sessions full feature tui's currently)
#
# alias cgt='sgpt '
# alias cgc='sgpt --chat '
# alias cgl='sgpt --list-chat '
# alias cgs='sgpt --show-chat '

# package management  {{{

# TODO: fzf pip/mamba packages


# pip  {{{

alias pp='pip list '
alias pl='pip list '
alias plz='pip list | ${FZ_PICKER} '
alias psh='pip show '
alias pi='pip install '
alias piu='pip install --upgrade '
alias pil='pip install -e '
alias pir='pip install -r '
alias pu='pip uninstall '
alias pf='pip freeze '

#  }}}


# pipupgrade  {{{

alias pgr='pipupgrade '
alias pgrs='pipupgrade --self '
alias pgrc='pipupgrade --check '
alias pgri='pipupgrade --interactive '
alias pgrl='pipupgrade --latest '
alias pgra='pipupgrade --all '
alias pgrr='pipupgrade --requirements '
alias pgrt='pipupgrade --upgrade-type '
alias pgrpr='pipupgrade --project '
alias pgrpf='pipupgrade --pipfile '

#  }}}


# pipx  {{{

alias px='pipx '
alias pxl='pipx list '

#  }}}


# mamba  {{{

alias mm='mamba '
alias mme='mamba activate '
alias mmqr='mamba repoquery -t '
alias mmde='mamba deactivate '
alias mmrm='mamba remove '
alias mmrme='mamba remove --all -n '
alias mmle='mamba info --envs '
alias mml='mamba info '
alias mmu='mamba update '
alias mmq='mamba search '
alias mmi='mamba install '
alias mmcr='mamba create -n '
alias mmcrc='mamba create --clone '
alias mmls='mamba list '
alias mmlz='mamba list | ${FZ_PICKER} '
alias mmlr='mamba list --revisions '
alias mmir='mamba install --revision '
alias mmr='mamba remove '
alias mmer='mamba env remove --name '

#  }}}


# mamba {{{

alias mi='micromamba '
alias mie='micromamba activate '
alias miqr='micromamba repoquery -t '
alias mide='micromamba deactivate '
alias mile='micromamba info --envs '
alias mil='micromamba info '
alias miu='micromamba update '
alias miq='micromamba search '
alias mii='micromamba install '
alias micr='micromamba create -n '
alias micrc='micromamba create --clone '
alias mils='micromamba list '
alias milz='micromamba list | ${FZ_PICKER} '
alias milr='micromamba list --revisions '
alias miir='micromamba install --revision '
alias mir='micromamba remove '
alias mier='micromamba env remove --name '

# }}}


#  }}}


# freqtrade  {{{

# TODO: script to read userinput for strategy, config, and other parameters with options for defaults
alias fqt='freqtrade '
alias fqtdk='freqtrade download-data -c user_data/configs/kucoin_empty.json -t 1m 3m 5m 15m 30m 1h 2h 4h 6h 8h 12h 1d --data-format-ohlcv hdf5'
alias fqku='~/git/ds/trade/exchange-proxy/dist/exchange-proxy -port 8080 -verbose 1 '
alias fqtr='bash ~/Scripts/freqtrade_helper.sh '
# alias fqtr1='freqtrade trade --strategy st00 --config user_data/strategies/configs/cfg.json --config user_data/strategies/configs/cp.json '

#  }}}


#  }}}

# hdf5  {{{

alias hgl='h5glance '
alias hdu='h5dump '
alias hls='h5ls '

#  }}}

# jq  {{{

alias jqr='jq-repl '
# alias ijq='ijq '

#  }}}

# rust  {{{



#  }}}

# zsh  {{{

alias zp='znap '
alias zc='znap clean '
alias zcl='znap clone '
alias zcml='znap compile '
alias ze='znap eval '
alias zfp='znap fpath '
alias zfn='znap function '
alias zign='znap ingnore '
alias zin='znap install '
alias zml='znap multi '
alias zpr='znap prompt '
alias zpl='znap pull '
alias zr='znap restart '
alias zs='znap source '
alias zst='znap status '

#  }}}

#  }}}

# --------------------------------------------

# version/key management  {{{

alias tg='topgrade '

# git  {{{


# TODO: use mani
#       gitui - needs gitdiff, barerepo/work-tree, other fixes

alias lg='lazygit'

# foreach aliaskey (a b bl c co d ds dt dts f l s sm) {
# 	alias g$aliaskey="git $aliaskey"
# }
# unset aliaskey

autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

# functions  {{{

function current_branch() {
    git_current_branch
}

# Pretty log messages
function _git_log_prettily(){
    if ! [ -z $1 ]; then
        git log --pretty=$1
    fi
}
compdef _git _git_log_prettily=git-log

# Warn if the current branch is a WIP
function work_in_progress() {
    command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

# Check if main exists and use instead of master
function git_main_branch() {
    command git rev-parse --git-dir &>/dev/null || return
    local ref
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
        if command git show-ref -q --verify $ref; then
            echo ${ref:t}
            return
        fi
    done
    echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
    command git rev-parse --git-dir &>/dev/null || return
    local branch
    for branch in dev devel development; do
        if command git show-ref -q --verify refs/heads/$branch; then
            echo $branch
            return
        fi
    done
    echo develop
}

#  }}}


# aliases  {{{


alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'

function gccd() {
    command git clone --recurse-submodules "$@"
    [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}
compdef _git gccd=git-clone

alias gcl='git clone '
alias gclp='git clone $(${PASTE_CMD})'
# TODO: gclp add cd to cloned repo
# alias gclpd='git clone $(${PASTE_CMD}) && cd # paste sed output'
alias gclean='git clean -id'
alias gpristine='git reset --hard && git clean -dffx'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout $(git_develop_branch)'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gcss='git commit -S -s'
alias gcssm='git commit -S -s -m'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'

function gdnolock() {
    git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gf='git fetch'
# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
    && alias gfa='git fetch --all --prune --jobs=10' \
    || alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gfg='git ls-files | grep'

alias gg='git gui citool'
alias gga='git gui citool --amend'

function ggf() {
    [[ "$#" != 1 ]] && local b="$(git_current_branch)"
    git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout
function ggfl() {
    [[ "$#" != 1 ]] && local b="$(git_current_branch)"
    git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggfl=git-checkout

function ggl() {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
        git pull origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git pull origin "${b:=$1}"
    fi
}
compdef _git ggl=git-checkout

function ggp() {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
        git push origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git push origin "${b:=$1}"
    fi
}
compdef _git ggp=git-checkout

function ggpnp() {
    if [[ "$#" == 0 ]]; then
        ggl && ggp
    else
        ggl "${*}" && ggp "${*}"
    fi
}
compdef _git ggpnp=git-checkout

function ggu() {
    [[ "$#" != 1 ]] && local b="$(git_current_branch)"
    git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout

alias ggpur='ggu'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'

alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log -g --pretty=%h) &!'

alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gm='git merge'
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
# alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gst='git status'

# use the default stash push on git 2.13 and newer
is-at-least 2.13 "$git_version" \
    && alias gstp:='git stash push' \
    || alias gstw='git stash save'
forgit_stash_show=gsts
forgit_stash_push=gstp
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstpo='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gstall='git stash --all'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'

alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias glum='git pull upstream $(git_main_branch)'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'

alias gam='git am'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gama='git am --abort'
alias gamscp='git am --show-current-patch'

function grename() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: $0 old_branch new_branch"
        return 1
    fi

    # Rename branch locally
    git branch -m "$1" "$2"
    # Rename branch in origin remote
    if git push origin :"$1"; then
        git push --set-upstream origin "$2"
    fi
}

unset git_version

#  }}}


# chezmoi  {{{

alias lgo="lazygit -p /home/xfo/git/system/dot/dotfiles "
alias oi="chezmoi "
alias oicd="chezmoi cd "
alias oiz="cd $(chezmoi source-path) "
alias oie="chezmoi edit --apply "
alias oist="chezmoi status "
alias oia="chezmoi add "
alias oiap='chezmoi add $(${PASTE_CMD})'
alias oiae="chezmoi add --encrypt "
alias oif="chezmoi forget "
alias oirm="chezmoi remove "
alias oip="chezmoi apply "
alias oicm="chezmoi commit "
alias oicma="chezmoi commit --all "
alias oira="chezmoi re-add "
alias oig="chezmoi git "
alias oid="chezmoi diff "
alias aiar="chezoi archive "
alias oiyp="chezmoi encrypt "
alias oidyp="chezmoi decrypt "
alias oim="chezmoi managed "
alias oium="chezmoi unmanaged "
alias oii="chezmoi ignored "
alias oiu="chezmoi update "

#  }}}


#  }}}

# aur  {{{

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
# For when keys break
alias aufx="sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys"

alias au='paru '
alias aux='paru -R '
alias auz='paruz '
alias auxz='paruz -R '
alias auxs='paru -Rs '
alias auxc='paru -Rc '
alias auxcs='paru -Rcns '
alias auxdp='paru -Qdtq | paru -Rs '
alias auxu='paru -Runs '
alias aups='paru -Ps '
alias aug='paru -G '
alias augp='paru -Gp '
alias augc='paru -Gc '
alias aus='paru -S '
alias auu='paru -U '
alias auqq='paru -Qq '
alias auqs='paru -Qs '
alias auf='paru -F '
alias auqm='paru -Qm '
alias ausi='paru -Si '
alias ausc='paru -Sc '
alias auc='paru -c '

#  }}}

# encrytion  {{{


# gpg  {{{

alias gpgc="gpg2 --keyserver-options auto-key-retrieve --verify" # verify signature for isos
alias gpgr="gpg2 --keyserver-options auto-key-retrieve --receive-keys" # receive the key of a developer

#  }}}


# age  {{{


#  }}}


#  }}}

#  }}}

# --------------------------------------------

# edit confs  {{{

# TODO:
# substitute using fzf - "fd ./pathlist_dir/* | fzf > selected" binding
# or provided paths
# provide a map of filenames and paths for fzf menu
function vocp() {
    alias vqa='vm /home/xfo/.config/qutebrowser/quickmarks '
    expanded_command=$(alias vqa)
    filepath=$(echo "$expanded_command" | grep -oE '\S+(~/|\./|/).* ')
    echo -n "$filepath" | ${COPY_CMD}
    echo "$filepath| ${COPY_CMD}"
}
# alias vd="fd --type=f --max-depth=1 -H . /home/xfo/git/system/dot/dotfiles/home/xfo/ | fzf"
# alias vc="fd --type=f --max-depth=1 -H . /home/xfo/git/system/dot/dotfiles/home/xfo/private_dot_config | fzf"
# alias vz="fd --type=f -H . /home/xfo/git/system/dot/dotfiles/home/xfo/private_dot_config/zsh | fzf | xargs -r -I {} vm {}"
# alias vb="fd --type=f --max-depth=1 -H . /home/xfo/git/system/dot/dotfiles/home/xfo/bin | fzf | xargs -r -I {} vm {}"
# alias vb="fd --type=f --max-depth=1 -H . /home/xfo/git/system/dot/dotfiles/home/xfo/bin | fzf | xargs -r -I {} vm {}"
# alias vvm="fd --type=f --max-depth=1 -H . /home/xfo/git/system/dot/dotfiles/home/xfo/private_dot_config/nvim/ | fzf | xargs -r -I {} vm {}"

alias vpenv='vm /etc/environment '
alias vpxd='vm /etc/profile.d/0000-xdg-dirs.sh '
alias vpvar='vm /etc/profile.d/set-vars.sh '

alias vprof='vm ~/.profile '

alias cdcr='cd /home/xfo/git/system/dot/files/root '
alias cdch='cd /home/xfo/git/system/dot/files/home '

alias vwk='vm /home/xfo/.config/wlr-which-key/config.yaml '
alias vwh='vm /home/xfo/.config/swhkd/swhkdrc '

alias vsd='vm /usr/local/bin/startsway '
alias vau='vm /home/xfo/.config/paru/paru.conf '

alias vsw='vm /home/xfo/.config/sway/config '
alias vsa='vm /home/xfo/.config/sway/autostart '
alias vst='vm /home/xfo/.config/sway/theme '
alias vwof='vm /home/xfo/.config/wofi/config '

alias voi="vm /home/xfo/.config/chezmoi/chezmoi.toml "
alias vtg="vm /home/xfo/.config/topgrade.toml "

alias vtx='vm /home/xfo/.config/tmux/tmux.conf '
alias valac='vm /home/xfo/.config/alacritty/alacritty.yml '
alias vkit='vm /home/xfo/.config/kitty/kitty.conf'
alias vwez='vm /home/xfo/.config/wezterm/wezterm.lua'
alias vlg='vm /home/xfo/.config/lazygit/config.yml '
alias vmus='vm /home/xfo/.config/cmus/rc '
alias vnm='vm /home/xfo/.config/mutt/muttrc '
alias vnb='vm /home/xfo/.config/newsboat/config '
alias vwrpd='vm /home/xfo/.config/warpd/config '
alias vdnst='vm /home/xfo/.config/dunst/dunstrc '
alias vrgr='vm /home/xfo/.config/ranger/rc.conf'
alias vawsm='vm /home/xfo/.config/awesome/rc.lua '
alias vq='vm /home/xfo/.config/qutebrowser/config.py '
alias vqa='vm /home/xfo/.config/qutebrowser/quickmarks '

alias vzrc='vm /home/xfo/.config/zsh/.zshrc '
alias vza='vm /home/xfo/.config/zsh/config/aliases.zsh '
alias vzw='vm /home/xfo/.config/zsh/config/widgets.zsh '
alias vzkb='vm /home/xfo/.config/zsh/config/keymaps.zsh '
alias vze='vm /home/xfo/.config/zsh/config/exports.zsh '
alias vzf='vm /home/xfo/.config/zsh/config/functions.zsh '
alias vzl='vm /home/xfo/.config/zsh/config/load.zsh '
alias vzp='vm /home/xfo/.config/zsh/config/plugins.zsh '
alias vzpr='vm /home/xfo/.config/zsh/.zprofile '

alias vvm='vm /home/xfo/.config/nvim/init.lua '
alias vvmp='vm /home/xfo/.config/nvim/lua/user/plugins.lua '
alias vvmw='vm /home/xfo/.config/nvim/lua/user/whichkey.lua '

#  }}}

# --------------------------------------------

# util  {{{


alias vvd='vivid ' # LS_COLORS generator

alias bitw='bitwise ' # bit calculator

alias bt='bartib ' # time tasks
alias tt='taskwarrior-tui ' # track tasks

alias gor='goread ' # rss
alias nc='ncmpcpp ' # music

#  }}}

# --------------------------------------------
