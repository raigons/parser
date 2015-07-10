module WhatsAppParser
  class Author
    attr_reader :name

    def initialize(fields={})
      @name = fields.fetch(:name)
    end
  end
end
