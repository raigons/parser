module WhatsAppParser
  module Collector
    autoload :HourCollector, "#{ROOT}/lib/collectors/hour_collector"
    autoload :DateCollector, "#{ROOT}/lib/collectors/date_collector"

    class Collector
      attr_reader :intervals

      def initialize
        @intervals = {}
      end

      def create_intervals(group_identifiers)
        group_identifiers.each do |identifier|
          unless intervals.has_key? range(identifier)
            lower_limit, upper_limit = limits(range(identifier))
            intervals[range(identifier)] = WhatsAppParser::Interval.new lower: lower_limit, upper: upper_limit
          end
        end
      end

      private

        def fill_intervals(messages, param)
          messages.each do |message|
            range = range(message.send(param))
            intervals[range].add_message message if intervals.has_key?range
          end
        end
    end
  end
end
