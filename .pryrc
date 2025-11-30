# ============================================================================
# Pry Configuration (.pryrc)
# ============================================================================
# Pry is an IRB alternative and runtime developer console for Ruby

# ============================================================================
# Custom Commands
# ============================================================================
# Repeat last command when pressing enter on empty line
Pry.config.commands.command(/^$/, 'repeat last command') do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end

# Execute code from clipboard (macOS pbpaste)
Pry.config.commands.command(/pbpaste/, 'enter paste mode') do
  tmp = `pbpaste`
  puts "== Pasting from clipboard ==\n#{tmp}\n== Executing ==\n"
  eval tmp
end

# ============================================================================
# Debugging Command Aliases
# ============================================================================
# Short aliases for common debugging commands
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
Pry.commands.alias_command 'b', 'break'

# ============================================================================
# Stripe-specific Configuration
# ============================================================================
### BEGIN STRIPE
env='local'

# Colorize prompt based on environment
envs_to_show = {
  'production' => Pry::Helpers::Text.red(Pry::Helpers::Text.bold('PRODUCTION')),
  'qa' => Pry::Helpers::Text.green('QA'),
  'devbox' => Pry::Helpers::Text.green('dev'),
}
Pry.config.prompt = proc {|obj, nest_level, _| "[#{envs_to_show[env]}] #{obj}:#{nest_level}> "}

# Use vim as the default editor
Pry.config.editor = 'vim'

### END STRIPE
