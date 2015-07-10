require 'spec_helper'

describe "Parser" do

  let :raw_message do
    "09/12/2014, 21:37 - Ramon Henrique: Hello world"
  end

  let :raw_message_2 do
    "09/12/2014, 22:08 - Ramon Henrique: hello again!"
  end

  let :raw_message_3 do
    "09/12/2014, 22:08 - Matheus Gonçalves: Hi!"
  end

  subject { WhatsAppParser::Parser.new }

  context "single messages" do
    it "should parse a single message into objects" do
      parsed = subject.parse_message(raw_message)[:message]
      expect(parsed).to be_a_kind_of WhatsAppParser::Message
      expect(parsed.content).to eq "Hello world"
      expect(parsed.hour).to eq "21:37"
      expect(parsed.date).to eq "09/12/2014"
      expect(parsed.author).to be_a_kind_of WhatsAppParser::Author
      expect(parsed.author.name).to eq "Ramon Henrique"
    end

    it "should parse messages with special chars" do
      message = "09/12/2014, 22:08 - Ramon Henrique: Hi, I wanna talk to you in 25/12/2014: test ;)"
      parsed = subject.parse_message(message)[:message]
      expect(parsed.date).to eq "09/12/2014"
      expect(parsed.hour).to eq "22:08"
      expect(parsed.content).to eq "Hi, I wanna talk to you in 25/12/2014: test ;)"
      expect(parsed.author.name).to eq "Ramon Henrique"
    end

    it "should parse correctly even if the message content includes dates and hours" do
      message = "09/12/2014, 22:08 - Ramon Henrique: Hi, now is 10/12,2014, 22:15 - am I correct?"
      parsed = subject.parse_message(message)[:message]
      expect(parsed.date).to eq "09/12/2014"
      expect(parsed.hour).to eq "22:08"
      expect(parsed.content).to eq "Hi, now is 10/12,2014, 22:15 - am I correct?"
    end

    it "should parse correctly if the message content includes dates, hours and owner name" do
      message = "01/12/2014, 23:58 - Ramon Henrique: Hi Matheus Gonçalves: now is 10/12,2014, 13:35 - am I correct?"
      parsed = subject.parse_message(message)[:message]
      expect(parsed.date).to eq "01/12/2014"
      expect(parsed.hour).to eq "23:58"
      expect(parsed.content).to eq "Hi Matheus Gonçalves: now is 10/12,2014, 13:35 - am I correct?"
      expect(parsed.author.name).to eq "Ramon Henrique"
    end

    it "should extract the message author as a standalone property" do
      parsed = subject.parse_message(raw_message)[:author]
      expect(parsed).to be_a_kind_of WhatsAppParser::Author
      expect(parsed.name).to eq "Ramon Henrique"
    end
  end

  context "multiples messages" do
    it "should parse a list of messages and return a list of objects" do
      parsed = subject.parse_messages([raw_message, raw_message_2])
      expect(parsed.count).to eq 2
      expect(parsed.first[:message].content).to eq "Hello world"
      expect(parsed.last[:message].content).to eq "hello again!"
    end

    it "should parse a list of messages from different authors" do
      parsed = subject.parse_messages [raw_message, raw_message_3, raw_message_2]
      expect(parsed.count).to eq 3
      expect(parsed.first[:message].content).to eq "Hello world"
      expect(parsed[1][:message].content).to eq "Hi!"
      expect(parsed.last[:message].content).to eq "hello again!"
    end
  end
end
