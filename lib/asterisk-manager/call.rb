module AsteriskManager
  class Call
    attr_accessor :channel_1,
                  :channel_2,
                  :created_at
    
    def initialize(arguments = {})
      self.channel_1  = arguments[:channel_1]
      self.channel_2  = arguments[:channel_2]
      self.created_at = Time.now
    end

    def age
      Time.now - created_at
    end

    def self.calls
      @calls ||= {}
    end

    def self.for_channel_1_and_channel_2(channel_1, channel_2)
      calls[ [ channel_1, channel_2 ] ] ||= new(channel_1: channel_1, channel_2: channel_2)
    end
  end
end
