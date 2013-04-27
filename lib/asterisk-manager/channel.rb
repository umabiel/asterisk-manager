module AsteriskManager
  class Channel
    attr_accessor :unique_id,
                  :sip_id,
                  :state,
                  :created_at
    
    def initialize(arguments = {})
      self.unique_id  = arguments[:unique_id]
      self.sip_id     = arguments[:sip_id]
      self.state      = arguments[:state]
      self.created_at = Time.now
    end

    def age
      Time.now - created_at
    end
  end
end
