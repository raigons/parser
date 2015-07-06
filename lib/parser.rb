module WhatsAppParser
	class Parser

    def initialize
      initialize_regex_hash
    end

		def parse_message raw_message
			{
				message: WhatsAppParser::Message.new(
									content: extract_content(raw_message),
                  date: extract_date(raw_message),
                  hour: extract_hour(raw_message),
									owner: extract_owner(raw_message))
		  }
		end

    private

    attr_reader :regex

    def initialize_regex_hash
      @regex = {}
      regex[:date] = /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/
      regex[:hour] = /\d+:\d+/
      regex[:hour_and_author] = /#{regex[:hour]} - \w+:/
      regex[:content] = /#{regex[:date]}, #{regex[:hour_and_author]} /
    end

    def extract_date raw_message
      raw_message[regex[:date]]
    end

    def extract_hour raw_message
      raw_message[regex[:hour]]
    end

    def extract_content raw_message
      raw_message.split(regex[:content]).reject(&:empty?).first
    end

    def extract_owner raw_message
      hour_and_message = raw_message[regex[:hour_and_author]]
      unless hour_and_message.nil?
        name = hour_and_message.split(Regexp.union(regex[:hour],/ - /)).compact.reject(&:empty?).first.chomp(":")
        return WhatsAppParser::Owner.new(name: name)
      end
    end
	end
end
