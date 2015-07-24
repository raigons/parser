require 'spec_helper'

describe "HourCollector" do

  let(:ramon) { WhatsAppParser::Author.new name: "Ramon" }
  let(:matheus) { WhatsAppParser::Author.new name: "Matheus" }

  let :messages do
    [
      WhatsAppParser::Message.new(content: "Message 1", hour: "1:00", author: ramon),
      WhatsAppParser::Message.new(content: "Message 2", hour: "1:01", author: matheus),
      WhatsAppParser::Message.new(content: "Message 3", hour: "1:01", author: matheus),
      WhatsAppParser::Message.new(content: "Message 4", hour: "2:02", author: ramon),
      WhatsAppParser::Message.new(content: "Message 5", hour: "3:03", author: ramon),
      WhatsAppParser::Message.new(content: "Message 6", hour: "3:05", author: matheus),
      WhatsAppParser::Message.new(content: "Message 7", hour: "4:00", author: ramon)
    ]
  end

  subject { WhatsAppParser::Collector::HourCollector.new }

  describe "#hour_range" do
    it "should create an limit range according to the hour" do
      expect(subject.hour_range("01:02")).to eq "01;02"
      expect(subject.hour_range("02:00")).to eq "02;03"
    end
  end

  describe "#group_messages" do
    it "should group messages by hours regardless the date" do
      group = subject.group_messages(messages)

      expected_group = {
        "01;02" => [messages[0..2]].flatten,
        "02;03" => [messages[3]],
        "03;04" => [messages[4..5]].flatten,
        "04;05" => [messages[6]]
      }

      expect(group).to eq expected_group
    end
  end
end
