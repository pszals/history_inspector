require './lib/cli'

oldstyle_filename = ARGV[0]
if oldstyle_filename
  history = File.read oldstyle_filename
else
  history = $stdin.read
end

$stdin.reopen "/dev/tty" unless $stdin.tty?

cli = CLI.new(STDIN, STDOUT, history)
cli.print_top_ten

while true
  puts "Search for count of a given command, or ctrl-c to quit"

  begin
    cli.show_count_for_command
  rescue Interrupt
    exit
  end

end
