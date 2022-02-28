module Test
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      include Import[:specification, :logger]

      ACTIONS = {config: Actions::Config.new}.freeze

      def initialize parser: Parser.new, actions: ACTIONS, **dependencies
        super(**dependencies)

        @parser = parser
        @actions = actions
      end

      def call arguments = []
        perform parser.call(arguments)
      rescue OptionParser::ParseError => error
        logger.error { error.message }
      end

      private

      attr_reader :parser, :actions

      def perform configuration
        case configuration
          in action_config: Symbol => action then config action
          in action_version: true then logger.info { specification.labeled_version }
          else usage
        end
      end

      def config(action) = actions.fetch(__method__).call(action)

      def usage = logger.unknown { parser.to_s }
    end
  end
end
