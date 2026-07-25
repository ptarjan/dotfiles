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
# Editor Configuration
# ============================================================================
# Use vim as the default editor
Pry.config.editor = 'vim'
