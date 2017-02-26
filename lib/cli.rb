require './lib/inspector'
require 'ascii_charts'

class CLI
  attr_reader :stdin, :stdout, :inspector

  def initialize(stdin, stdout, history)
    @stdin = stdin
    @stdout = stdout
    @inspector ||= Inspector.new(encode(history))
  end

  def print_top_ten
    stats = inspector.top_ten
    stdout.puts format_results(stats)
    stdout.puts ascii_chart(stats)
    stdout.puts bar_graph(stats)
  end

  def ascii_chart(stats)
    AsciiCharts::Cartesian.new(stats).draw
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

  def encode(history)
    history.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
  end
end
