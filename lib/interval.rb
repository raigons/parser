module WhatsAppParser
  class Interval
    def initialize(args)
      @messages = []
      @lower_limit = args.fetch(:lower)
      @upper_limit = args.fetch(:upper)
    end

    def interval
      "#{lower_limit.rjust(2,'0')};#{upper_limit.rjust(2,'0')}"
    end

    def add_message message
      messages << message
    end

    def count_messages
      messages.count
    end

    private

    attr_reader :messages, :lower_limit, :upper_limit
  end
end
