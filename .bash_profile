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
