while [ -h "$SOURCE" ]; do SOURCE="$(readlink "$SOURCE")"; done
GITROOT="$(builtin cd -P "$(dirname "$SOURCE")" && git root)"
SCRIPTS="$GITROOT/scripts"
CUSTOM_PATHS=$SCRIPTS

# Config
source $GITROOT/default/config

# clear custom paths to avoid duplication
PATH=`echo $PATH | sed "s|$CUSTOM_PATHS:||g"`
# add custom paths
export PATH=$CUSTOM_PATHS:$PATH

# RVM
if [[ -x $HOME/.rvm ]] ; then
  if ! (env | grep PATH | grep .rvm > /dev/null); then
    source "$HOME/.rvm/scripts/rvm"
  fi
  DEFAULT_GEMSET=`cat $HOME/.ruby-version`
  rvm use system >/dev/null 2>&1
  [ -n "$DEFAULT_GEMSET" ] && (rvm use $DEFAULT_GEMSET 2>/dev/null)
fi

# VIM
alias vi='TERM="xterm-256color" vim'
alias vim='TERM="xterm-256color" vim'

# EDITOR
export EDITOR=vim
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# GEM
alias "gem-clear"='gem list | cut -d" " -f1 | xargs gem uninstall -aIx'

# Git
alias "g"="git"
alias "git-new-workdir"="/usr/share/doc/git/contrib/workdir/git-new-workdir"
#export GIT_PROXY_COMMAND="proxy"
