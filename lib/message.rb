module WhatsAppParser
  class Message

    attr_reader :content, :date, :hour, :owner

    def initialize(fields={})
      @content = fields.fetch(:content) { nil }
      @date = fields.fetch(:date) { nil }
      @hour = fields.fetch(:hour) { nil }
      @owner = fields.fetch(:owner) { nil }
    end
  end
end
