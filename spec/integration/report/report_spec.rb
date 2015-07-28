require 'spec_helper'

describe 'Report' do

  let(:parser) { WhatsAppParser::Parser.new }

  let(:filename) { "spec/file_samples/example.txt" }

  let(:loader) { WhatsAppParser::Loader.new(filename: filename) }

  let!(:chat_parser) { WhatsAppParser::ChatParser.new(parser: parser, loader: loader)}

  subject { WhatsAppParser::Reports::Report.new chat_parser, WhatsAppParser::Collector::HourCollector.new }

  describe "#count_by_user" do
    it "should count messages per user and return it grouped" do
      report = subject.count_messages_by_user
      response = { "Karen" => 8, "Ramon Henrique" => 11 }

      expect(report).to eq response
    end
  end

  describe "#count_messages_per_hour" do
    it "should return a counting of messages per each hour" do
      report = subject.count_messages_per_hour

      response = { "21;22" => 1, "22;23" => 12, "07;08" => 2, "08;09" => 3, "09;10" => 1 }
      expect(report).to eq response
    end
  end
end
