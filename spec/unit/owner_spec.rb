require 'spec_helper'

describe "Owner" do
  subject { WhatsAppParser::Owner.new name: "Ramon Henrique" }

  it { should respond_to :name }

  it "should return name" do
    expect(subject.name).to eq "Ramon Henrique"
  end
end
