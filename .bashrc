# .bashrc

# User specific aliases and functions

# Source global definitions
# master.bashrc is meant to be sourced by all bash users so be careful
#
# if you are looking instead at ~/.bashrc then do whatever you want!

# please uncomment these two lines in your personal ~/.bashrc:
export ADMIN_SCRIPTS=~engshare/admin/scripts
source "$ADMIN_SCRIPTS"/master.bashrc

# this keeps you up to date with the latest master.bashrc changes; if you opt
# not to, you'll be on you own staying up to date with general changes

# if you want to be able to easily make, test, and commit changes to
# master.bashrc and master.shellrc in svnroot/admin/scripts:
# - checkout a copy of svnroot/admin to ~/admin
# - cron it to auto-up (having a stale ~/admin is asking for pain)
# - source master.bashrc from your ~/.bashrc instead like so:
# export ADMIN_SCRIPTS=~/svnroot/admin/scripts
# source "$ADMIN_SCRIPTS"/master.bashrc

# when you copy master.bashrc to ~/.bashrc you don't have to actually keep
#   the remainder of these lines (since they are pulled in by sourcing
#   master.bashrc), though you can (doing them twice is harmless and adds
#   negilble time to the loading of the shell)
# instead you can start making your personal modifications


if [[ -z "$ADMIN_SCRIPTS" ]]
then
  export ADMIN_SCRIPTS='/home/engshare/admin/scripts'
fi

# things that work in more than just bash
source "$ADMIN_SCRIPTS"/master.shellrc

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

ESCAPED_HOME=`echo $HOME | sed -r "s:/:\\\\\\/:g"`

PS1='\[\033[0;33m\]\t\[\033[0;0m\] \[\033[${PROMPT_COLOR}\]\u@\h\[\033[0;0m\]:`pwd | sed -r "s/${ESCAPED_HOME}/~/" | sed -r "s/^.*\/(.*)(\/.*)(\/.*)$/\1\2\3/"`$(__git_ps1 " (%s)")\$ '

#alias phpsh="www/scripts/phpsh/phpsh"

#if [ $TERM != 'screen' ]; then
#    screen -A -x
#fi

export PYTHONPATH=$PYTHONPATH:../parsers/mechanize

EDITOR=vim; export EDITOR

# Aliases
alias ar='~/www/scripts/static_resources/analyze_resources'
alias ar2='~/www2/scripts/static_resources/analyze_resources'
alias ar3='~/www3/scripts/static_resources/analyze_resources'
alias arc='/home/engshare/devtools/arcanist/bin/arc'
alias tbgs='tbgs --forcedir "~/www"'
alias fbgrep='tbgs'
alias grepfb='tbgs'
alias s='scan'
alias g='git'
alias cleanup='find . -type f -name "._*" -exec rm {} \;'
alias tail1s='tail -f ~/logs/error_log_ptarjan | pretty | grep error | grep -v "error.php" | grep -v "#1"'
alias tail1='tail -f ~/logs/error_log_ptarjan | pretty'
alias ut='cd ~/www/scripts/unittest/bin'
alias uta='./run_all_unittests --test-root ../tests/streams'
alias gs='git status'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias gcom='git checkout master; git rebase trunk'
alias grit='git rebase -i trunk'
alias gco='git checkout'
alias gdbr='git branch -d'
alias gcam='git commit -am'
alias gd='git diff'
alias gd1='git diff HEAD~1'
alias gcob='git checkout -b'
alias grt='git rebase trunk'
alias gsh='git show --pretty=short --stat'
alias gca='git commit --amend -CHEAD -a'
alias gclean='git branch -d `git branch | grep -v "*"`'
alias rt='cd ~/www'
alias restart_hphp='sudo su -l -c "sudo webserver restart"'
alias restart_apache='sudo su -l -c "/var/www/scripts/pusher/pusher_agent reload"'
alias phpsh='phpsh ~/scripts/default.php'
alias amap='rt; ./scripts/lite/generate-autoload-map.php; cd - 2>&1 > /dev/null'
alias vi='vim'
alias cm='~/www/flib/_bin/checkModule'
alias cmc='cm -c'

function f(){ find . -iname "*$@*.*" | grep "$@"; }

# Python environment vars
export HIVE_RLWRAP=true
source /mnt/vol/hive/dis/lib/utils/hive.include
hive_select_release silver

shopt -s progcomp
       
_git_branches()
{
  local curw
  COMPREPLY=()
  curw=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W "`git branch 2> /dev/null | cut -c 3-`" -- "$curw"))
  return 0
}        
         
if [ -t 0 -a $TERM != 'screen' ]; then
    screen -A -R default
fi

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

export HIVE_RLWRAP=true
source /mnt/vol/hive/dis/lib/utils/hive.include
hive_select_release silver.latest

# dont do Control+S
stty -ixon


# python virtual env
# PATH=/home/ptarjan/usr/virtual-python-2.6/bin:$PATH

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#   export TERM='xterm-256color'
# else
#   export TERM='xterm-color'
# fi
