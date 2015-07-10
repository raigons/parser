module WhatsAppParser
  class Parser

    def initialize
      initialize_regex_hash
    end

    def parse_messages raw_messages
      raw_messages.map { |raw_message| parse_message(raw_message) }
    end

    def parse_message raw_message
      author = extract_author(raw_message)
      {
        message:
          WhatsAppParser::Message.new(
                  content: extract_content(raw_message),
                  date: extract_date(raw_message),
                  hour: extract_hour(raw_message),
                  author: author),
        author: author
      }
    end

    private

    attr_reader :regex

    def initialize_regex_hash
      @regex = {}
      regex[:date] = /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/
      regex[:hour] = /\d+:\d+/
      regex[:hour_and_author] = /#{regex[:hour]} - (.+?):/
      regex[:content] = /#{regex[:date]}, #{regex[:hour_and_author]} /
    end

    def extract_date raw_message
      raw_message[regex[:date]]
    end

    def extract_hour raw_message
      raw_message[regex[:hour]]
    end

    def extract_content raw_message
      raw_message.split(regex[:content]).compact.reject(&:empty?).last
    end

    def extract_author raw_message
      hour_and_message = raw_message[regex[:hour_and_author]]
      unless hour_and_message.nil?
        name = hour_and_message.split(Regexp.union(regex[:hour],/ - /)).compact.reject(&:empty?).first.chomp(":")
        return WhatsAppParser::Author.new(name: name)
      end
    end
  end
end
