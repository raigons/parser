#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.require

module WhatsAppParser
  ROOT = File.dirname(__FILE__)

  autoload :Message, "#{ROOT}/lib/message"
  autoload :Chat, "#{ROOT}/lib/chat"
  autoload :Owner, "#{ROOT}/lib/owner"
  autoload :Parser, "#{ROOT}/lib/parser"
end
