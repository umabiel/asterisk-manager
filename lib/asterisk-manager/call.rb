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

    def seconds
      Time.now - created_at
    end

    def duration
      x = seconds.round
      hours   = x / 3600
      minutes = (x - hours * 3600) / 60
      seconds = (x - hours * 3600 - minutes * 60)
      "#{hours}:#{'%02d' % minutes}:#{'%02d' % seconds}"
    end

    def self.calls
      @calls ||= {}
    end

    def self.for_channel_1_and_channel_2(channel_1, channel_2)
      calls[ [ channel_1, channel_2 ] ] ||= new(channel_1: channel_1, channel_2: channel_2)
    end
  end
end
