require 'spec_helper'

describe "ChatParser" do

  let(:parser) { WhatsAppParser::Parser.new }

  let :messages do
    [
      "09/12/2014, 21:37 - Ramon Henrique: Hello world",
      "09/12/2014, 22:08 - Matheus Gonçalves: Hi!",
      "09/12/2014, 22:08 - Ramon Henrique: hello again!"
    ]
  end

  let "messages_2" do
    [
      "09/12/2014, 23:01 - Ramon Henrique: Hi, all!",
      "09/12/2014, 23:02 - Ramon Henrique: Hi, hi!",
      "09/12/2014, 23:03 - Ramon Henrique: I am here!",
      "09/12/2014, 23:04 - Ramon Henrique: Bye, John :)",
    ]
  end

  subject { WhatsAppParser::ChatParser.new(parser, messages) }

  describe "#participants" do
    it "should return participants" do
      participants = subject.participants
      expect(participants.count).to eq 2
      expect(participants.first.name).to eq "Ramon Henrique"
      expect(participants.last.name).to eq "Matheus Gonçalves"
    end
  end

  describe "#parse_chat" do
    it "should parse all messages and participants into a chat" do
      all_messages = messages + messages_2
      chat_parser = WhatsAppParser::ChatParser.new(parser, all_messages)
      chat = chat_parser.parse_chat

      expect(chat.count_messages).to eq 7
      expect(chat.count_participants).to eq 2
    end
  end
end
