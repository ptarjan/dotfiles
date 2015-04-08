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

PROMPT_COLOR='0;32m'
if [ ${UID} -eq 0 ]; then
  PROMPT_COLOR='0;31m'
fi

ESCAPED_HOME=`echo $HOME | sed "s:/:\\\\\\/:g"`

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

# android
export ANDROID_HOME=`brew --prefix android`

# more history
HISTSIZE=130000 HISTFILESIZE=-1

PATH=~/bin:/usr/local/bin:$PATH:/usr/local/sbin

