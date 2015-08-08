require 'spec_helper'

describe "DateCollector" do

  let(:ramon) { WhatsAppParser::Author.new name: "Ramon" }
  let(:matheus) { WhatsAppParser::Author.new name: "Matheus" }

  let :messages do
    [
      WhatsAppParser::Message.new(content: "Message 1", hour: "1:00", date: "01/08/2015", author: ramon),
      WhatsAppParser::Message.new(content: "Message 2", hour: "1:01", date: "01/08/2015", author: matheus),
      WhatsAppParser::Message.new(content: "Message 3", hour: "1:01", date: "02/08/2015", author: matheus),
      WhatsAppParser::Message.new(content: "Message 4", hour: "2:02", date: "03/08/2015", author: ramon),
      WhatsAppParser::Message.new(content: "Message 5", hour: "3:03", date: "03/08/2015", author: ramon),
      WhatsAppParser::Message.new(content: "Message 6", hour: "3:05", date: "03/08/2015", author: matheus),
      WhatsAppParser::Message.new(content: "Message 7", hour: "4:00", date: "11/08/2015", author: ramon)
    ]
  end

  subject { WhatsAppParser::Collector::DateCollector.new }

  describe "#group_messages" do
    it "should group messages by date" do
      subject.group_messages(messages)

      expect(subject.intervals["01/08/2015"].count_messages).to eq 2
      expect(subject.intervals["02/08/2015"].count_messages).to eq 1
      expect(subject.intervals["03/08/2015"].count_messages).to eq 3
      expect(subject.intervals["11/08/2015"].count_messages).to eq 1
    end
  end
end
