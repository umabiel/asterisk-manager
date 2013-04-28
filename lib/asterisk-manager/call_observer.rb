module AsteriskManager
  class CallObserver
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
      channel_1        = Channel.for_unique_id(event['Uniqueid1'])
      channel_2        = Channel.for_unique_id(event['Uniqueid2'])
      channel_1.sip_id = event['Channel1']
      channel_2.sip_id = event['Channel2']
      Call.for_channel_1_and_channel_2 channel_1, channel_2
    end

    def unlink(event)
      Call.calls.delete([ Channel.for_unique_id(event['Uniqueid1']), Channel.for_unique_id(event['Uniqueid2']) ])
    end
  end
end
