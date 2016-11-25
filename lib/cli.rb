require './lib/inspector'

class CLI
  attr_reader :stdin, :stdout, :inspector

  def initialize(stdin = STDIN, stdout = STDOUT, path_to_histfile='history.txt')
    @stdin = stdin
    @stdout = stdout
    @inspector ||= Inspector.new(read_and_encode(path_to_histfile))
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

  def read_and_encode(history)
    File.read(history).encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
  end
end
