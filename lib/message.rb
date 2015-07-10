module WhatsAppParser
  class Message

    attr_reader :content, :date, :hour, :author

    def initialize(fields={})
      @content = fields.fetch(:content) { nil }
      @date = fields.fetch(:date) { nil }
      @hour = fields.fetch(:hour) { nil }
      @author = fields.fetch(:author) { nil }
    end
  end
end
