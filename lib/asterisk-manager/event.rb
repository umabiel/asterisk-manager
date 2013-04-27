module AsteriskManager
  class Event
    attr_accessor :attributes

    def initialize(attributes = {})
      self.attributes = attributes.freeze
    end

    def type
      attributes['Event']
    end

    def [](key)
      attributes[key]
    end
  end
end
