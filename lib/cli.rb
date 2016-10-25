require './lib/inspector'

class CLI
  attr_reader :std_in, :std_out

  def initialize(std_in = STDIN, std_out = STDOUT)
    @std_in = std_in
    @std_out = std_out
  end

  def print_top_ten
    std_out.puts format_results(Inspector.new.top_ten)
  end

  def format_results(results)
    results.map {|command, count| "#{count} #{command}"}
  end
end
