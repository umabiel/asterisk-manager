module AsteriskManager
  class ChannelObserver
    def subscribe(event_listener)
      event_listener.subscribe self, 'Newchannel', 'Newstate', 'Hangup'
    end

    def receive_event(event)
      case event.type
      when 'Newchannel'
        new_channel(event)
      when 'Newstate'
        new_state(event)
      when 'Hangup'
        hangup(event)
      end
    end

    def new_channel(event)
      channel        = Channel.for_unique_id(event['Uniqueid'])
      channel.sip_id = event['Channel']
      channel.state  = event['ChannelStateDesc']
    end

    def new_state(event)
      channel        = Channel.for_unique_id(event['Uniqueid'])
      channel.state  = event['ChannelStateDesc']
    end

    def hangup(event)
      Channel.channels.delete event['Uniqueid']
    end
  end
end
