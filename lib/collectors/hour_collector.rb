module WhatsAppParser
  module Collector
    class HourCollector
      def group_messages(messages)
        group = {}
        messages.each do |message|
          range = hour_range(message.hour)
          group[range] = [] unless group.has_key? range
          group[range] << message
        end
        group
      end

      def hour_range(time)
        base = time.split(":").first
        upper_limit = base.to_i + 1
        "#{base.rjust(2,'0')};#{upper_limit.to_s.rjust(2,'0')}"
      end

      private

      attr_reader :group
    end
  end
end
