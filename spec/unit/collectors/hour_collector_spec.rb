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

  describe "#range" do
    it "should create an limit range according to the hour" do
      expect(subject.range("01:02")).to eq "01;02"
      expect(subject.range("02:00")).to eq "02;03"
    end
  end

  describe "#create_intervals" do
    it "should create a list of intervals given a list os hours sent" do
      subject.create_intervals(messages.map { |message| message.hour })
      expect(subject.intervals.count).to eq 4
      expect(subject.intervals.values.first.interval).to eq "01;02"
      expect(subject.intervals.values.last.interval).to eq "04;05"
    end
  end

  describe "#group_messages" do
    it "should group messages by hours regardless the date" do
      subject.group_messages(messages)

      expect(subject.intervals.keys).to eq ["01;02", "02;03", "03;04", "04;05"]
      expect(subject.intervals["01;02"].count_messages).to eq 3
      expect(subject.intervals["03;04"].count_messages).to eq 2
    end
  end
end
