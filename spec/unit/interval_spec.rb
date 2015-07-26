require 'spec_helper'

describe 'Interval' do

  let(:ramon) { WhatsAppParser::Author.new name: "Ramon" }

  let(:matheus) { WhatsAppParser::Author.new name: "Matheus" }

  let(:message_1) { WhatsAppParser::Message.new(content: "Message 1", hour: "1:00", author: ramon) }

  let(:message_2) { WhatsAppParser::Message.new(content: "Message 2", hour: "1:01", author: matheus) }

  let(:message_3) { WhatsAppParser::Message.new(content: "Message 3", hour: "1:01", author: matheus) }

  subject { WhatsAppParser::Interval.new(lower: "01", upper: "02") }

  describe "#interval" do
    it "should return the interval in a form of string" do
      expect(subject.interval).to eq "01;02"
    end
  end

  describe "#add_message" do
    it "should add a message to interval" do
      subject.add_message message_1
      subject.add_message message_2
      subject.add_message message_3

      expect(subject.count_messages).to eq 3
    end
  end
end
