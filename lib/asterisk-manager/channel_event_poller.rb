module AsteriskManager
  class ChannelEventPoller
    attr_accessor :connection,
                  :poll_thread

    def initialize(arguments = {})
      self.connection = arguments[:connection]
    end

    def subscribe(event_listener)
      event_listener.subscribe self, 'CoreShowChannel'
    end

    def receive_event(event)
      case event.type
      when 'CoreShowChannel'
        core_show_channel(event)
      end
    end

    def core_show_channel(event)
      channel         = Channel.for_unique_id(event['UniqueID'])
      channel.sip_id  = event['Channel']
      channel.state   = event['ChannelStateDesc']
      duration_pieces = event['Duration'].split(':')
      duration        = duration_pieces[0].to_i * 3600 + duration_pieces[1].to_i * 60 + duration_pieces[2].to_i
      channel.created_at = Time.now - duration
      if event['BridgedUniqueID'] != ''
        bridged_channel        = Channel.for_unique_id(event['BridgedUniqueID'])
        bridged_channel.sip_id = event['BridgedChannel']
        channel_1, channel_2 = [ channel, bridged_channel ].sort
        Call.for_channel_1_and_channel_2 channel_1, channel_2
      end
    end

    def poll
      self.poll_thread = Thread.new do
        loop do
          connection.send "Action: CoreShowChannels\r\n"
          connection.send "\r\n"
          sleep 5
        end
      end
    end
  end
end
