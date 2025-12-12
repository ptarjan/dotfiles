# .bashrc

# ============================================================================
# INTERACTIVE SHELL CHECK
# ============================================================================

# Exit if not running interactively
if [ -z "$PS1" ]; then
  return
fi

if [[ ! $PS1 ]]; then
  exit;
fi


# ============================================================================
# SHELL OPTIONS
# ============================================================================

# Fix long line entry wrapping in bash
shopt -s checkwinsize

# Enable programmable completion
shopt -s progcomp


# ============================================================================
# HISTORY SETTINGS
# ============================================================================

# Keep lots of history
HISTSIZE=130000
HISTFILESIZE=-1


# ============================================================================
# EDITOR AND TERMINAL SETTINGS
# ============================================================================

# Default editor
EDITOR=vim; export EDITOR

# Enable colors
export CLICOLOR=1

# Disable Control+S (flow control)
stty -ixon

# <CTRL>-W will stop at /
# COMP_WORDBREAKS=$COMP_WORDBREAKS/


# ============================================================================
# BASH COMPLETION
# ============================================================================

# macOS completions
if [[ "$OSTYPE" == "darwin"* ]]; then
    # brew install bash-completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
          . $(brew --prefix)/etc/bash_completion
    fi
    # brew install bazel
    if [ -f $(brew --prefix)/etc/bash_completion.d/bazel-complete.bash ]; then
          . $(brew --prefix)/etc/bash_completion.d/bazel-complete.bash
    fi
fi

# Git completion
# Source git-completion.bash and set up completion for 'g' alias
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  # Complete g the same as git (requires __git_complete from git-completion.bash)
  __git_complete g git
fi


# ============================================================================
# PROMPT CONFIGURATION
# ============================================================================

# Set prompt color based on user (red for root, green for normal user)
PROMPT_COLOR='0;32m'
if [ ${UID} -eq 0 ]; then
  PROMPT_COLOR='0;31m'
fi

# Escaped home path for prompt
ESCAPED_HOME=`echo $HOME | sed "s:/:\\\\\\/:g"`

# Git prompt support
source ~/.git-prompt.sh

# Custom prompt: shows shortened path and git branch
PS1='\[\033[${PROMPT_COLOR}\]`pwd | sed "s/${ESCAPED_HOME}/~/" | sed "s/^.*\/\(.*\)\(\/.*\)\(\/.*\)$/\1\2\3/"`\[\033[0;0m\]$(__git_ps1 " %s ")\$ '

# Alternative prompts (commented out)
# PS1='\[\033[0;33m\]\t\[\033[0;0m\] \[\033[${PROMPT_COLOR}\]\u@\h\[\033[0;0m\]:`pwd | sed "s/${ESCAPED_HOME}/~/" | sed "s/^.*\/\(.*\)\(\/.*\)\(\/.*\)$/\1\2\3/"`$(__git_ps1 " %s ")\$ '
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
# PS1="\[\033[G\]$PS1"


# ============================================================================
# PATH CONFIGURATION
# ============================================================================

# Go
export GOPATH=~/gocode/
export PATH=$PATH:$GOPATH/bin

# PKG config
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig/

# Custom paths
PATH=$PATH:~/stripe/sorbet/bazel-bin/main/
PATH=$PATH:~/bin

# Remove this since it seems to already be coming from somewhere else...
# PATH=~/bin:/usr/local/bin:$PATH:/usr/local/sbin


# ============================================================================
# SSH AGENT SETUP
# ============================================================================

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


# ============================================================================
# TOOL INTEGRATIONS
# ============================================================================

# --- FZF (Fuzzy Finder) ---
export FZF_DEFAULT_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore'"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore'"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# --- iTerm2 Shell Integration ---
# https://iterm2.com/documentation-shell-integration.html
source ~/.iterm2_shell_integration.`basename $SHELL`

# --- NVM (Node Version Manager) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ============================================================================
# COMPANY-SPECIFIC CONFIGURATIONS
# ============================================================================

# --- Stripe ---
if [ -f ~/.stripe-repos.sh ]; then
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

    # BEGIN STRIPE NODE CONFIG
    #      To undo the following behavior, comment it out, dont delete it;
    #      'pay-server/scripts/frontend/install_node_modules' will just add it again.
    #      Ask in #dashboard-platform or #iteng if you have questions.
    export PATH="./node_modules/.bin:$PATH"
    # END STRIPE NODE CONFIG

    # added by travis gem
    [ -f /Users/pt/.travis/travis.sh ] && source /Users/pt/.travis/travis.sh
fi

# --- Robinhood ---
export APOLLO_NAMESPACE=paul-tarjan
export ROBINHOOD_EMAIL=paul.tarjan@robinhood.com


# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# Robinhood test aliases
alias ut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true ./manage.py test --nologcapture --nocapture"
alias mut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false ./manage.py test --nologcapture --noinput --nocapture"
alias nut="DJANGO_SETTINGS_MODULE=settings.local.server ./manage.py fast_migrate -t -x DJANGO_SETTINGS_MODULE=settings.local.server ./manage.py test --nologcapture --nocapture --keepdb"

# Kubectl shell - quickly get a shell in a running pod
kshell () {
	pod=$(kubectl get pods --no-headers -o=custom-columns=NAME:.metadata.name --field-selector=status.phase=Running | grep ^$1 | head -1)
	container=""
	[[ ! -z $2 ]] && container="-c=$2"
	if [ ! -z $pod ]
	then
		kubectl exec -it $pod $container -- /bin/sh -c "which /bin/bash >/dev/null && exec /bin/bash || exec /bin/sh"
	else
		echo "No pods matching \"$1\" were found in the current namespace: \"$(kubectl config view --minify --output 'jsonpath={..namespace}')\""
		return 1
	fi
}
