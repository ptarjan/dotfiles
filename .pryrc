Pry.config.commands.command(/^$/, 'repeat last command') do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end

Pry.config.commands.command(/pbpaste/, 'enter paste mode') do
  tmp = `pbpaste`
  puts "== Pasting from clipboard ==\n#{tmp}\n== Executing ==\n"
  eval tmp
end

Pry.config.commands.command(/s/, 'step') do
  _pry_.input = StringIO.new('step')
end

Pry.config.commands.command(/n/, 'next') do
  _pry_.input = StringIO.new('next')
end
