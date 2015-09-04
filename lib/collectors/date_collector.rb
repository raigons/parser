module WhatsAppParser
  module Collector
    class DateCollector < Collector
      def group_messages(messages)
        create_intervals(messages.map { |m| m.date }.uniq)
        fill_intervals(messages, :date)
      end

      def range(time)
        time
      end

      private

        def limits(range)
          lower_limit = range
          splitted_date = lower_limit.split "/"
          upper_limit = splitted_date.unshift((splitted_date.shift.to_i + 1).to_s.rjust(2, '0')).join("/")
          return lower_limit, upper_limit
        end
    end
  end
end
