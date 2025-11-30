# .bash_profile
# Executed by bash for login shells
# For non-login shells, ~/.bashrc is sourced instead

# ============================================================================
# Source .bashrc
# ============================================================================
# Get the aliases and functions from .bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# ============================================================================
# Stripe-specific Configuration
# ============================================================================
### BEGIN STRIPE
if [ -f ~/.stripe_profile ]; then
  source ~/.stripe_profile
fi
### END STRIPE

### BEGIN HENSON
export PATH="/Users/pt/stripe/henson/bin:$PATH"
### END HENSON

# Stripe tools
export PATH="/Users/pt/stripe/password-vault/bin:$PATH"
export PATH="/Users/pt/stripe/space-commander/bin:$PATH"

# ============================================================================
# System Paths
# ============================================================================
# System binaries
export PATH="/usr/local/sbin:$PATH"

# LLVM and build tools
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/thrift@0.9/bin:$PATH"

# MySQL client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# ============================================================================
# Ruby Environment
# ============================================================================
# rbenv - Ruby version management
export PATH="/Users/pt/.rbenv/shims:$PATH"
export PATH="/Users/pt/.rbenv/bin:$PATH"

# ============================================================================
# Python Environment
# ============================================================================
### BEGIN ANSIBLE MANAGED BLOCK
# pyenv - Python version management
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi

# virtualenvwrapper configuration
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME="$HOME/.virtualenvs"
pyenv virtualenvwrapper_lazy

# OpenSSL flags for Python compilation
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
### END ANSIBLE MANAGED BLOCK

# ============================================================================
# Development Tools
# ============================================================================
# Visual Studio Code
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# ============================================================================
# Project-specific Configuration
# ============================================================================
# Robinhood project settings
export PROJECT_HOME="/Users/paul.tarjan/robinhood"
export PATH="$PATH:$HOME/robinhood/phabricator/arcanist/bin/"

# ============================================================================
# iTerm2 Integration
# ============================================================================
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
