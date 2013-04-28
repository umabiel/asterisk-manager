module AsteriskManager
  class Conference
    attr_accessor :name

    def initialize(arguments = {})
      self.name = arguments[:name]
    end

    def channels
      Channel.channels.values.select do |channel|
        channel.application_name == 'ConfBridge' && channel.application_data.split(',').first == name
      end
    end

    def self.conferences
      conferences = {}
      Channel.channels.values.each do |channel|
        if channel.application_name == 'ConfBridge'
          name = channel.application_data.split(',').first
          conferences[name] = new(name: name)
        end
      end
      conferences
    end

    def self.for_name(name)
      conferences[name] ||= new(name: name)
    end
  end
end
