module WhatsAppParser
  module Reports
    attr_accessor :collector

    class Report
      def initialize chat_parser, collector
        @chat_parser = chat_parser
        @collector = collector
        @chat = @chat_parser.parse_chat
      end

      def count_messages_by_user
        group_message_counter_by_author.reduce(&:merge)
      end

      def count_messages_per_hour
        @collector.group_messages chat.all_messages
        group = {}

        @collector.intervals.each do |key, interval|
          group[key] = interval.count_messages
        end

        group
      end

      private

      def group_message_counter_by_author
        chat_parser.participants.map do |author|
          { author.name.to_s => chat.count_messages_of(author) }
        end
      end

      attr_reader :chat_parser, :chat
    end
  end
end
