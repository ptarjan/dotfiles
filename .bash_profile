# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

shopt -s checkwinsize

source /home/engshare/admin/scripts/ssh/manage_agent.sh

unset USERNAME
source "$ADMIN_SCRIPTS"/ssh/manage_rootcanal.sh
