class Inspector
  def initialize(history = File.read("history.txt"))
    @history = history
  end

  def top(n)
    top_commands.take(n)
  end

  def top_ten
    top(10)
  end

  private

  attr_reader :history

  def top_commands
    commands = history.split("\n").map do |line|
      remove_line_numbers(line)
    end

    count_commands(commands).sort_by { |_, count| count }.reverse
  end

  def count_commands(commands)
    commands.reduce({}) do |memo, (_, command)|
      c = combine_first_two(command)
      memo[c] ? memo[c] += 1 : memo[c] = 1
      memo
    end
  end

  def remove_line_numbers(line)
    line.lstrip.split("  ", 2)
  end

  def combine_first_two(line)
    commands = line.split(" ", 3)
    if commands[1]
      [commands[0], commands[1]].join(" ")
    else
      commands[0]
    end
  end
end
