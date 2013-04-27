module AsteriskManager
  class ChannelObserver
    attr_accessor :channels

    def initialize(attributes = {})
      self.channels = {}
    end

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
      channels[event['Uniqueid']] = Channel.new unique_id: event['Uniqueid'],
                                                sip_id:    event['Channel'],
                                                state:     event['ChannelStateDesc']
    end

    def new_state(event)
      channels[event['Uniqueid']].state = event['ChannelStateDesc']
    end

    def hangup(event)
      channels.delete event['Uniqueid']
    end
  end
end
