Pry.config.commands.command(/^$/, 'repeat last command') do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end

Pry.config.commands.command(/pbpaste/, 'enter paste mode') do
  tmp = `pbpaste`
  puts "== Pasting from clipboard ==\n#{tmp}\n== Executing ==\n"
  eval tmp
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
Pry.commands.alias_command 'b', 'break'
