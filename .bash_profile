# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
### BEGIN STRIPE
if [ -f ~/.stripe_profile ]; then
  source ~/.stripe_profile
fi
### END STRIPE

### BEGIN HENSON
export PATH="/Users/pt/stripe/henson/bin:$PATH"
### END HENSON
export PATH="/usr/local/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"

export PATH="/Users/pt/.rbenv/shims:$PATH"
export PATH="/Users/pt/.rbenv/bin:$PATH"
export PATH="/Users/pt/stripe/password-vault/bin:$PATH"
export PATH="/Users/pt/stripe/space-commander/bin:$PATH"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="/usr/local/opt/thrift@0.9/bin:$PATH"
export PROJECT_HOME="/Users/paul.tarjan/robinhood"
export PATH="$PATH:$HOME/robinhood/phabricator/arcanist/bin/"
# BEGIN ANSIBLE MANAGED BLOCK
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME="$HOME/.virtualenvs"
pyenv virtualenvwrapper_lazy
export CPPFLAGS=-I$(brew --prefix openssl)/include
export LDFLAGS=-L$(brew --prefix openssl)/lib
# END ANSIBLE MANAGED BLOCK
