module WhatsAppParser
  module Collector
    class HourCollector < Collector
      def group_messages(messages)
        create_intervals(messages.map { |m| m.hour })

        messages.each do |message|
          range = hour_range(message.hour)
          intervals[range].add_message message if intervals.has_key?range
        end
      end

      def limits(range)
        lower_limit, upper_limit = range.split ";"
      end

      def range(time)
        hour_range(time)
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
