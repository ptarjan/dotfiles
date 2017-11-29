# .bashrc

if [ -z "$PS1" ]; then
  return
fi

#
# bash-specific things below
#
if [[ ! $PS1 ]]; then
  exit;
fi

# fix long line entry wrapping in bash
shopt -s checkwinsize

shopt -s progcomp

export CLICOLOR=1
PROMPT_COLOR='0;32m'
if [ ${UID} -eq 0 ]; then
  PROMPT_COLOR='0;31m'
fi

ESCAPED_HOME=`echo $HOME | sed "s:/:\\\\\\/:g"`
GIT_PROMPT=/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
if [ ! -f $GIT_PROMPT ]; then 
  GIT_PROMPT=~/.git-prompt.sh
fi

GIT_COMPLETION=/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
if [ -f $GIT_COMPLETION ]; then 
  . $GIT_COMPLETION
fi
# Complete g the same as git
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
  || complete -o default -o nospace -F _git g

source $GIT_PROMPT

# gogogogo
export GOPATH=~/gocode/
export PATH=$PATH:$GOPATH/bin

PS1='\[\033[0;33m\]\t\[\033[0;0m\] \[\033[${PROMPT_COLOR}\]\u@\h\[\033[0;0m\]:`pwd | sed "s/${ESCAPED_HOME}/~/" | sed "s/^.*\/\(.*\)\(\/.*\)\(\/.*\)$/\1\2\3/"`$(__git_ps1 " (%s)")\$ '
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
# PS1="\[\033[G\]$PS1"

EDITOR=vim; export EDITOR

# dont do Control+S
stty -ixon

# <CTRL>-W will stop at /
# COMP_WORDBREAKS=$COMP_WORDBREAKS/

# keep lots of history
HISTSIZE=130000
HISTFILESIZE=-1

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    # /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

# https://iterm2.com/documentation-shell-integration.html
source ~/.iterm2_shell_integration.`basename $SHELL`

# First you have to:
# brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# more history
HISTSIZE=130000 HISTFILESIZE=-1

# Remove this since it seems to already be coming from somewhere else...
# PATH=~/bin:/usr/local/bin:$PATH:/usr/local/sbin
PATH=$PATH:~/bin

# Stripe
. /Users/pt/.rbenvrc
. ~/.stripe-repos.sh
export AWS_ACCESS_KEY_ID=":"
export AWS_SECRET_ACCESS_KEY=":"
# BEGIN STRIPE NODE CONFIG
#      To undo the following behavior, comment it out, dont delete it;
#      'pay-server/scripts/frontend/install_node_modules' will just add it again.
#      Ask in #frontend-infra or #iteng if you have questions.
export PATH="node_modules/.bin:$PATH"
# END STRIPE NODE CONFIG
