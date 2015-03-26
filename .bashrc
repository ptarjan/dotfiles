# .bashrc

if [ -z "$PS1" ]; then
  return
fi

export ADMIN_SCRIPTS='/home/engshare/admin/scripts'
if [[ -d "$ADMIN_SCRIPTS" ]]
then
  source "$ADMIN_SCRIPTS"/master.bashrc
  source "$ADMIN_SCRIPTS"/master.shellrc
fi

source /etc/profile.d/manage_rootcanal.sh

#
# bash-specific things below
#
if [[ ! $PS1 ]]; then
  exit;
fi

# fix long line entry wrapping in bash
shopt -s checkwinsize

#PATH=$PATH:/home/ptarjan/svnroot/admin/facebook/scripts:/usr/local/bin/phpsh:/home/ptarjan/scripts
#export PATH

source ~/.bashrc_git_custom_completion

PROMPT_COLOR='0;32m'
if [ ${UID} -eq 0 ]; then
  PROMPT_COLOR='0;31m'
fi

ESCAPED_HOME=`echo $HOME | sed "s:/:\\\\\\/:g"`

PS1='\[\033[0;33m\]\t\[\033[0;0m\] \[\033[${PROMPT_COLOR}\]\u@\h\[\033[0;0m\]:`pwd | sed "s/${ESCAPED_HOME}/~/" | sed "s/^.*\/\(.*\)\(\/.*\)\(\/.*\)$/\1\2\3/"`$(__git_ps1 " (%s)")\$ '
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
# PS1="\[\033[G\]$PS1"

EDITOR=vim; export EDITOR

# Aliases
alias ls='ls -G'
alias vi='vim'

function f(){ find . -iname "*$@*.*" | grep "$@"; }

shopt -s progcomp

_git_branches()
{
  local curw
  COMPREPLY=()
  curw=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W "`git branch 2> /dev/null | cut -c 3-`" -- "$curw"))
  return 0
}

# autocomplete ssh
rhosts=localhost
if [ -f ~/.ssh/known_hosts ] ; then
  rhosts="$rhosts `cat ~/.ssh/known_hosts | awk '{print $1}' | sed -e 's/,.*//g'`"
fi
#if [ -f /etc/hosts ] ; then
#       rhosts="$rhosts `cat /etc/hosts | awk '!/(#.*|127.*)/ {print $2}'`"
#fi
complete -W "`echo $rhosts`" telnet ssh sftp ftp ping traceroute nslookup dig
unset rhosts

# dont do Control+S
stty -ixon

# <CTRL>-W will stop at /
# COMP_WORDBREAKS=$COMP_WORDBREAKS/

# python virtual env
# PATH=/home/ptarjan/usr/virtual-python-2.6/bin:$PATH

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#   export TERM='xterm-256color'
# else
#   export TERM='xterm-color'
# fi


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

PATH=~/bin:/usr/local/bin:$PATH:/usr/local/sbin
