module WhatsAppParser
  class ChatParser
    def initialize(args)
      @parser = args.fetch(:parser)
      @loader = args.fetch(:loader)
      load_messages
      parse_messages
    end

    def parse_chat
      chat = WhatsAppParser::Chat.new
      parsed.each_with_index do |parsed_message, index|
        chat.add_participant parsed_message[:author]
        chat.add_message parsed_message[:message], parsed_message[:author]
      end
      chat
    end

    def participants
      @authors ||= parsed.map { |p| p[:author] }.uniq { |author| author.name }
    end

    private

    def load_messages
      @loader.load_messages
    end

    def parse_messages
      @parsed = parser.parse_messages(raw_messages)
    end

    def raw_messages
      @raw_messages ||= @loader.messages
    end

    attr_reader :parser, :parsed, :authors
  end
end
