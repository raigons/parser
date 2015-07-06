require 'spec_helper'

describe "Parser" do

	let(:raw_message) do
		"09/12/2014, 21:37 - Ramon: Hello world"
	end

	subject { WhatsAppParser::Parser.new }

	it "should parse a single message into objects" do
		parsed = subject.parse_message(raw_message)
		expect(parsed[:message]).to be_a_kind_of WhatsAppParser::Message
		expect(parsed[:message].content).to eq "Hello world"
    expect(parsed[:message].hour).to eq "21:37"
    expect(parsed[:message].date).to eq "09/12/2014"
		expect(parsed[:message].owner).to be_a_kind_of WhatsAppParser::Owner
    expect(parsed[:message].owner.name).to eq "Ramon"
	end
end
