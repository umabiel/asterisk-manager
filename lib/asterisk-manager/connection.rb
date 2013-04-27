require 'socket'

module AsteriskManager
  class Connection
    attr_accessor :host,
                  :port,
                  :username, 
                  :password
    
    def initialize(arguments = {})
      self.host     = arguments[:host]
      self.port     = arguments[:port]
      self.username = arguments[:username]
      self.password = arguments[:password]
    end

    def socket
      @socket ||= TCPSocket.new host, port
    end

    def send(value)
      socket.write value
    end

    def login
      send "Action: Login\r\n"
      send "Username: #{username}\r\n"
      send "Secret: #{password}\r\n"
      send "\r\n"
    end
  end
end
