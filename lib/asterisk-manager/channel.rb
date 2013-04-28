module AsteriskManager
  class Channel
    attr_accessor :unique_id,
                  :sip_id,
                  :state,
                  :caller_id_number,
                  :caller_id_name,
                  :application_name,
                  :application_data,
                  :created_at
    
    def initialize(arguments = {})
      self.unique_id        = arguments[:unique_id]
      self.sip_id           = arguments[:sip_id]
      self.state            = arguments[:state]
      self.caller_id_number = arguments[:caller_id_number]
      self.caller_id_name   = arguments[:caller_id_name]
      self.application_name = arguments[:application_name]
      self.application_data = arguments[:application_data]
      self.created_at       = Time.now
    end

    def application
      "#{application_name}(#{application_data})" if application_name.size > 0
    end

    def caller_id
      "#{caller_id_number} #{caller_id_name}".strip
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

    def <=>(other_channel)
      unique_id.to_f <=> other_channel.unique_id.to_f
    end

    def self.channels
      @channels ||= {}
    end

    def self.for_unique_id(unique_id)
      channels[unique_id] ||= new(unique_id: unique_id)
    end
  end
end
