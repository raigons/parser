require 'spec_helper'

describe "Loader" do
  let(:filename) { "spec/file_samples/example.txt" }

  let(:parser) { WhatsAppParser::Parser.new }

  subject { WhatsAppParser::Loader.new(filename: filename) }

  describe "#load_messages" do
    it "should load messages from file" do
      subject.load_messages
      expect(subject.messages.count).to eq 19
    end

    context "formatting messages" do
      before do
        subject.load_messages
      end

      it "should format messages from file removing line breaker char" do
        expect(subject.messages[1]).not_to include "\\n"
      end

      it "should keep the order of the messages" do
        expect(subject.messages[0]).to eq "09/12/2014, 21:37 - Karen: test example 0"
        expect(subject.messages[7]).to eq "09/12/2014, 22:11 - Ramon Henrique: test example 7"
        expect(subject.messages[18]).to eq "10/12/2014, 09:20 - Karen: test example 18 😉"
      end
    end

    context "messages with more than one line" do
      let :loader do
        WhatsAppParser::Loader.new(filename: filename.gsub(/\/example.txt/, '/example_2.txt'))
      end

      let :loader_2 do
        WhatsAppParser::Loader.new(filename: filename.gsub(/\/example.txt/, '/example_3.txt'))
      end

      it "should join messages" do
        loader.load_messages
        expect(loader.messages.count).to eq 1
        expect(loader.messages[0]).to eq "13/12/2014, 01:02 - Karen: yyyyy. xxxxdddd. 😢 Hello, hi, houdy, y'all. thanks See ya, bye"
      end

      it "should be able to deal with multiline messages inside a list of messages" do
        loader_2.load_messages
        expect(loader_2.messages.count).to eq 7
        expect(loader_2.messages[2]).to eq "09/12/2014, 22:08 - Karen: yyyyy. xxxxdddd. 😢 Hello, hi, houdy, y'all. thanks See ya, bye"
        expect(loader_2.messages[4]).to eq "09/12/2014, 22:08 - Ramon Henrique: test example 4"
      end
    end
  end
end
