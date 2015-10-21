require './whatsapp_parser'

namespace :report do
  parser = WhatsAppParser::Parser.new
  hour_collector = WhatsAppParser::Collector::HourCollector.new

  desc "A report about everything"
  task :group_message_per_hour, [:txt_file] do |t, args|
    loader = WhatsAppParser::Loader.new filename: args[:txt_file]
    chat_parser = WhatsAppParser::ChatParser.new parser: parser, loader: loader

    report = WhatsAppParser::Reports::Report.new chat_parser, hour_collector
    puts "Total of messages => #{report.count_messages_by_user}\n"
    counting_per_hour = report.count_messages_per_hour

    puts "validating counter => #{counting_per_hour.values.reduce(:+)}\n"
    p counting_per_hour.sort_by { |_key, value| value }.reverse.to_h
  end
end
