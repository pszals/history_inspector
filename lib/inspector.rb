class Inspector
  def initialize(history)
    @history ||= history
    @command_counts ||= count_commands(isolated_commands)
  end

  def top(n)
    top_commands.take(n)
  end

  def top_ten
    top(10)
  end

  def count(command)
    command_counts[command].to_i
  end

  private

  attr_accessor :command_counts
  attr_reader :history

  def top_commands
    command_counts.sort_by { |_, count| count }.reverse
  end

  def isolated_commands
    history.split("\n").map do |line|
      remove_line_numbers(line)
    end
  end

  def count_commands(commands)
    commands.reduce({}) do |memo, command|
      c = combine_first_two(command)
      memo[c] ? memo[c] += 1 : memo[c] = 1
      memo
    end
  end

  def remove_line_numbers(line)
    if line_comes_from_histfile?(line)
      line.split(/:.*;/)[1]
    else
      line.lstrip.split(/\d+../, 2)[1]
    end
  end

  def combine_first_two(line)
    if line
      commands = line.split(" ", 3)
      commands[1] ? [commands[0], commands[1]].join(" ") : commands[0]
    end
  end

  def line_comes_from_histfile?(line)
    line[0] == ':'
  end
end
