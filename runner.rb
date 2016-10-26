require './lib/cli'

cli = CLI.new
cli.print_top_ten

while true
  puts "Search for count of a given command, or ctrl-c to quit"

  begin
    cli.show_count_for_command
  rescue Interrupt
    exit
  end

end
