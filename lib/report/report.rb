module WhatsAppParser
  module Reports
    class Report
      def initialize chat_parser
        @chat_parser = chat_parser
        @chat = @chat_parser.parse_chat
      end

      def count_messages_by_user
        group_message_counter_by_author.reduce(&:merge)
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
