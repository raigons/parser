require 'spec_helper'

describe "WhatsAppParser::Chat" do

  subject { WhatsAppParser::Chat.new }

  let :ramon do
    double(:user, {name: "Ramon Henrique"})
  end

  let :matheus do
    double(:user, {name: "Matheus Gonçalves"})
  end

  let :message do
    double(:message, {content: 'Hello', owner: ramon})
  end

  let :message_2 do
    double(:message, {content: "Hi there!", owner: matheus})
  end

  it "should add message to list" do
    subject.add_participants([ramon])

    subject.add_message(message, ramon)

    expect(subject.count_messages).to eq 1

    subject.add_message(message, ramon)

    expect(subject.count_messages).to eq 2
  end

  it "should add participant" do
    subject.add_participant(ramon)

    expect(subject.count_participants).to eq 1
  end

  it "should add more than one participant at once" do
    subject.add_participants([ramon, matheus])

    expect(subject.count_participants).to eq 2
  end

  it "should get messages by user" do
    subject.add_participants([ramon, matheus])
    subject.add_message(message, ramon)
    subject.add_message(message_2, matheus)

    expect(subject.count_messages).to eq 2
    expect(subject.find_message_by_user(ramon)).to eq [message]
    expect(subject.find_message_by_user(matheus)).to eq [message_2]
  end

  it "should count messages by user when adding a new one" do
    subject.add_participants([ramon, matheus])
    expect(subject.count_messages_of(ramon)).to eq 0

    subject.add_message(message, ramon)
    expect(subject.count_messages_of(ramon)).to eq 1
    expect(subject.count_messages_of(matheus)).to eq 0
    expect(subject.count_messages).to eq 1
  end
end
