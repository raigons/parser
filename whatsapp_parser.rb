#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.require

module WhatsAppParser
  ROOT = File.dirname(__FILE__)

  autoload :Message, "#{ROOT}/lib/message"
  autoload :Chat, "#{ROOT}/lib/chat"
  autoload :Author, "#{ROOT}/lib/author"
  autoload :Parser, "#{ROOT}/lib/parser/parser"
  autoload :ChatParser, "#{ROOT}/lib/parser/chat_parser"
  autoload :Loader, "#{ROOT}/lib/loader"
  autoload :Reports, "#{ROOT}/lib/report/reports"
  autoload :Collector, "#{ROOT}/lib/collectors/collectors"
end
