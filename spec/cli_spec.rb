require './lib/cli'

class Spy
  attr_accessor :output
  def initialize
    @output = []
  end

  def puts(thing)
    output << thing
  end
end

describe CLI do
  let(:formatted_results) { ["1 foo", "2 bar"] }
  let(:fake_results) { [["foo", 1], ["bar", 2]] }
  let(:spy) { Spy.new }
  let(:cli) { CLI.new(double, spy) }

  it 'prints the top ten results with a graph' do
    allow_any_instance_of(Inspector).to receive(:top_ten).and_return(fake_results)

    cli.print_top_ten

    expect(spy.output.first).to eq(formatted_results)
    expect(spy.output.last).to include(cli.bar_graph(fake_results))
  end

  it 'formats results' do
    expect(cli.format_results(fake_results)).to eq(formatted_results)
  end

  it 'displays bars as a representation of percentage of commands' do
    foo_count = 67
    bar_count = 33
    stats = [["foo", foo_count], ["bar", bar_count ]]
    foo_bars = "#"*foo_count
    bar_bars = "#"*bar_count

    expect(cli.bar_graph(stats)).to include("#{foo_bars} #{foo_count}")
  end

  it 'converts counts to a number out of 100' do
    foo_count = 90
    bar_count = 30
    stats = [["foo", foo_count], ["bar", bar_count ]]

    expect(cli.out_of_100(stats)).to eq([["foo", 75], ["bar", 25]])
  end
end
