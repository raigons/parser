module WhatsAppParser
  class Chat

    def initialize
      @participants = {}
    end

    def add_message message, user
      return unless participants.has_key? user.name
      participants[user.name][:messages] << message
    end

    def add_messages messages
      messages.each do |message|
        add_participant message.author
        add_message message, message.author
      end
    end

    def all_messages
      participants.values.map { |participant_values| participant_values[:messages] }.flatten
    end

    def count_messages
      participants.map { |key, value| participants[key][:messages] }.flatten.count
    end

    def count_messages_of user
      find_message_by_user(user).count
    end

    def add_participant participant
      return if participants.has_key? participant.name

      participants[participant.name] = {
        participant: participant,
        messages: []
      }
    end

    def add_participants users
      users.each { |participant| add_participant(participant) }
    end

    def count_participants
      participants.count
    end

    def find_message_by_user user
      participants[user.name].fetch(:messages) { [] }
    end

    private

    attr_reader :participants
  end
end
