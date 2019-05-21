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
### BEGIN STRIPE
env='local'

# COLORISE PROMPT
envs_to_show = {
  'production' => Pry::Helpers::Text.red(Pry::Helpers::Text.bold('PRODUCTION')),
  'qa' => Pry::Helpers::Text.green('QA'),
  'devbox' => Pry::Helpers::Text.green('dev'),
}
Pry.config.prompt = proc {|obj, nest_level, _| "[#{envs_to_show[env]}] #{obj}:#{nest_level}> "}

Pry.config.editor = 'vim'

### END STRIPE
