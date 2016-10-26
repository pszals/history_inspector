require './lib/inspector'

class CLI
  attr_reader :stdin, :stdout, :inspector

  def initialize(stdin = STDIN, stdout = STDOUT)
    @stdin = stdin
    @stdout = stdout
    @inspector ||= Inspector.new
  end

  def print_top_ten
    stdout.puts format_results(inspector.top_ten)
    stdout.puts bar_graph(inspector.top_ten)
  end

  def bar_graph(stats)
    out_of_100(stats).reduce("") do |memo, (command, occurences)|
      memo += "#{'#'*occurences} #{occurences.to_s}% -- #{command.to_s}\n"
    end
  end

  def out_of_100(stats)
    total = stats.reduce(0) {|memo, (command, occurences)| memo += occurences}
    stats.map { |command, occurences| [command, occurences = (occurences.to_f/total.to_f*100).round] }
  end

  def show_count_for_command
    stdout.puts(inspector.count(get_input))
  end

  def format_results(results)
    results.map { |command, count| "#{count} #{command}" }
  end

  def get_input
    command = stdin.gets.chomp
  end
end
