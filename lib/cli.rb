require './lib/inspector'

class CLI
  attr_reader :std_in, :std_out, :inspector

  def initialize(std_in = STDIN, std_out = STDOUT)
    @std_in = std_in
    @std_out = std_out
    @inspector ||= Inspector.new
  end

  def print_top_ten
    std_out.puts format_results(inspector.top_ten)
    std_out.puts bar_graph(inspector.top_ten)
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

  def format_results(results)
    results.map { |command, count| "#{count} #{command}" }
  end
end
