# return if not interactive
# use case if posix compliance is needed
[[ $- != *i* ]] && return

# emacs mode
bindkey -e
autoload -Uz compinit && compinit
# End of lines added by compinstall

# history
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=1000


# pushd
# NOTE: something like a dir browse mode?
# DIRSTACKSIZE=100

# echo ${(t)PATH}

# sources
for d in "$ZDOT_DIR/rc/rc.d/"*.zsh
do
    [ -r "$d" ] && . "$d"
done
unset d

# set paths to unique
typeset -U path fpath
typeset -U PATH FPATH

# funcs
fpath+=("$ZDOT_DIR/rc/func.d")
export fpath

for f in "$ZDOT_DIR/rc/func.d/"*(@)
do
    [ -r "$f" ] && autoload -Uz ${f:t:r}
done
unset f

repos=(
    'romkatv/zsh-defer'

    # 'junegunn/fzf'
    # 'ajeetdsouza/zoxide'

    'zsh-users/zsh-completions'
    'zsh-users/zsh-autosuggestions'

    'zsh-users/zsh-syntax-highlighting'
    'zsh-users/zsh-history-substring-search'

    )

plugin-load $repos

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

source <(rg --generate complete-zsh)

# sodot
alias sodot='/usr/bin/git --git-dir=$HOME/source/.sodot/ --work-tree=/home/soda'

# sysodot
alias sysodot='/usr/bin/git --git-dir=$HOME/source/.sysodot/ --work-tree=/'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias history='history -DE'
