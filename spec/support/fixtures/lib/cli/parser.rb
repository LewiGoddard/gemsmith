require "optparse"

module Test
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      CLIENT = OptionParser.new nil, 40, "  "

      # Order is important.
      SECTIONS = [Parsers::Core].freeze

      def initialize sections: SECTIONS, client: CLIENT, container: Container
        @sections = sections
        @client = client
        @configuration = container[:configuration].dup
      end

      def call arguments = []
        sections.each { |section| section.call configuration, client: }
        client.parse arguments
        configuration.freeze
      end

      def to_s = client.to_s

      private

      attr_reader :sections, :client, :configuration
    end
  end
end
