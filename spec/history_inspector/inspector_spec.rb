require 'history_inspector/inspector'

describe Inspector do
  let(:history)  { "1  one command \n2  two command two\n2  two command two" }
  let(:commands) { ["1  a", "2  b", "3  c", "4  d", "5  e", "6  f", "7  g", "8  h", "9  i", "10  j", "11  k"].join("\n") }
  let(:inspector) { described_class.new(history) }

  describe "#top(n)" do
    it "counts command line commands" do
      expect(inspector.top_ten).to eq([["two command", 2], [ "one command", 1]])
    end
  end

  describe "#top_ten" do
    it "takes only the top ten" do
      expect(described_class.new(commands).top_ten.count).to eq 10
    end
  end

  describe "#count" do
    it "finds count for a given commad" do
      expect(inspector.count("one command")).to eq 1
      expect(inspector.count("two command")).to eq 2
    end

    it "handles the case when the command is not found" do
      expect(inspector.count("foobar")).to eq 0
    end
  end
end
