require "spec_helper"

RSpec.describe Test::CLI::Shell do
  using Refinements::Pathnames

  subject(:shell) { described_class.new actions: described_class::ACTIONS.merge(config:) }

  include_context "with temporary directory"

  let(:config) { instance_spy Test::CLI::Actions::Config }

  describe "#call" do
    it "edits configuration" do
      shell.call %w[--config edit]
      expect(config).to have_received(:call).with(:edit)
    end

    it "views configuration" do
      shell.call %w[--config view]
      expect(config).to have_received(:call).with(:view)
    end

    it "prints version" do
      expectation = proc { shell.call %w[--version] }
      expect(&expectation).to output(/Test\s\d+\.\d+\.\d+/).to_stdout
    end

    it "prints help (usage)" do
      expectation = proc { shell.call %w[--help] }
      expect(&expectation).to output(/Test.+USAGE.+/m).to_stdout
    end

    it "prints usage when no options are given" do
      expectation = proc { shell.call }
      expect(&expectation).to output(/Test.+USAGE.+/m).to_stdout
    end

    it "prints error with invalid option" do
      expectation = proc { shell.call %w[--bogus] }
      expect(&expectation).to output(/invalid option.+bogus/).to_stdout
    end
  end
end