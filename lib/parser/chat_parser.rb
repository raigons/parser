module WhatsAppParser
  class ChatParser
    def initialize(parser, messages)
      @parser = parser
      @raw_messages = messages
      parse_messages
    end

    def parse_chat
      chat = WhatsAppParser::Chat.new
      parsed.each do |parsed_message|
        chat.add_participant parsed_message[:author]
        chat.add_message parsed_message[:message], parsed_message[:author]
      end
      chat
    end

    def participants
      @authors ||= parsed.map { |p| p[:author] }.uniq { |author| author.name }
    end

    private

    def parse_messages
      @parsed = parser.parse_messages(raw_messages)
    end

    attr_reader :parser, :parsed, :raw_messages, :authors
  end
end
