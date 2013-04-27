module AsteriskManager
  class CallObserver
    attr_accessor :calls

    def initialize(attributes = {})
      self.calls = {}
    end

    def subscribe(event_listener)
      event_listener.subscribe self, 'Bridge', 'Unlink'
    end

    def receive_event(event)
      case event.type
      when 'Bridge'
        bridge(event)
      when 'Unlink'
        unlink(event)
      end
    end

    def bridge(event)
      begin
      channel_1 = Channel.new unique_id: event['Uniqueid1'], sip_id: event['Channel1']
      channel_2 = Channel.new unique_id: event['Uniqueid2'], sip_id: event['Channel2']
      call = Call.new channel_1: channel_1, channel_2: channel_2
      calls[ [ channel_1.unique_id, channel_2.unique_id ] ] = call
      rescue Exception => exception
        puts exception.to_s
      end
    end

    def unlink(event)
      calls.delete([ event['Uniqueid1'], event['Uniqueid2'] ])
    end
  end
end
