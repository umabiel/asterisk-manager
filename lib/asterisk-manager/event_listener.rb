require 'thread'

module AsteriskManager
  class EventListener
    attr_accessor :connection,
                  :subscribers,
                  :listen_thread

    def initialize(arguments = {})
      self.connection = arguments[:connection]
      self.subscribers = {}
    end

    def subscribe(subscriber, *event_types)
      subscribers[subscriber] ||= []
      subscribers[subscriber]  |= event_types
    end
    
    def unsubscribe(subscriber, *event_types)
      if event_types
        subscribers[subscriber] -= event_types
      else
        subscribers.delete subscriber
      end
    end

    def notify_subscribers(event)
      subscribers.each_pair do |subscriber, event_types|
        if event_types.include?(event.type)
          subscriber.receive_event(event)
        end
      end
    end

    def listen
      self.listen_thread = Thread.new do
        event_attributes = {}
        loop do
          line = connection.socket.gets
          if line == "\r\n"
            notify_subscribers Event.new(event_attributes)
            event_attributes = {}
          else
            key, value = line.chomp.split(': ', 2)
            event_attributes[key] = value
          end
        end
      end
    end
  end
end
