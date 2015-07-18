module WhatsAppParser
  class Loader

    attr_reader :messages

    def initialize(args)
      @filename = args.fetch(:filename)
    end

    def load_messages
      @messages = File.readlines(filename)
      format_messages
    end

    private

    def format_messages
      last_default_index = 0
      cached_messages = []

      messages.each_with_index do |message, index|
        last_default_index = replace_or_join_messages message, index, last_default_index, cached_messages
      end

      @messages = cached_messages.compact
    end

    def replace_or_join_messages(message, index, last_default_index, cached_messages)
      if is_default_format? message
        cached_messages[index] = format_message message
        return index
      else
        cached_messages[last_default_index] += " ".concat(format_message(message))
        return last_default_index
      end
    end

    def format_message message
      message[0..-2].strip
    end

    def is_default_format? message
      message.match /[0-9]{2}\/[0-9]{2}\/[0-9]{4}, \d+:\d+ - (.+)?/
    end

    attr_reader :filename
  end
end
