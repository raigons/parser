module WhatsAppParser
  module Collector
    class HourCollector
      attr_reader :intervals

      def initialize
        @intervals = {}
      end

      def group_messages(messages)
        create_intervals(messages.map { |m| m.hour })

        messages.each do |message|
          range = hour_range(message.hour)
          intervals[range].add_message message if intervals.has_key?range
        end
      end

      def create_intervals(hours)
        hours.each do |hour|
          hour_range = hour_range(hour)
          unless intervals.has_key? hour_range
            lower_limit, upper_limit = hour_range.split(";")
            intervals[hour_range] = WhatsAppParser::Interval.new lower: lower_limit, upper: upper_limit
          end
        end
      end

      def hour_range(time)
        base = time.split(":").first
        upper_limit = base.to_i + 1
        "#{base.rjust(2,'0')};#{upper_limit.to_s.rjust(2,'0')}"
      end

      private

      attr_reader :interval
    end
  end
end
