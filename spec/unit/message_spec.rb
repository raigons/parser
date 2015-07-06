require 'spec_helper'

describe "WhatsAppParser::Message" do

  subject { WhatsAppParser::Message.new }

  it { should respond_to :content }
  it { should respond_to :date }
  it { should respond_to :hour }
  it { should respond_to :owner }
end
