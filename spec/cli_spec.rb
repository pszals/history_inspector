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

  it 'prints the top ten results' do
    allow_any_instance_of(Inspector).to receive(:top_ten).and_return(fake_results)

    cli.print_top_ten

    expect(spy.output.first).to eq(formatted_results)
  end

  it 'formats results' do
    expect(cli.format_results(fake_results)).to eq(formatted_results)
  end
end
