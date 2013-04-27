asterisk-manager
================
Ruby Gem for connecting to an Asterisk server via the AMI (Asterisk Manager
Interface) protocol.


Events
------
Create a connection and login

    connection = AsteriskManager::Connection.new host:     'asterisk.example.com',
                                                 port:     5038,
                                                 username: 'admin',
                                                 password: 'secret'
    connection.login

Setup an EventListener

    event_listener = EventListener.new connection: connection
    event_listener.listen

Setup a ChannelObserver and have it subscribe to events via the EventListener

    channel_observer = ChannelObserver.new
    channel_observer.subscribe event_listener

Setup a CallObserver and have it subscribe to events via the EventListener

    call_observer = CallObserver.new
    call_observer.subscribe event_listener

Now make a call and take a look

    channel_observer.channels.inspect
      {
        "1367101866.1995" => #<AsteriskManager::Channel @unique_id="1367101866.1995",
                                                        @sip_id="SIP/501-0000078b",
                                                        @state="Up",
                                                        @created_at=2013-04-27 15:31:07 -0700>,
        "1367101866.1996" => #<AsteriskManager::Channel @unique_id="1367101866.1996",
                                                        @sip_id="SIP/203-0000078c",
                                                        @state="Up",
                                                        @created_at=2013-04-27 15:31:07 -0700>
      }

    call_observer.calls.inspect
      {
        [ "1367101866.1995", "1367101866.1996" ] => #<AsteriskManager::Call
          @channel_1=#<AsteriskManager::Channel @unique_id="1367101866.1995",
                                                @sip_id="SIP/501-0000078b",
                                                @state=nil,
                                                @created_at=2013-04-27 15:31:07 -0700>,
          @channel_2=#<AsteriskManager::Channel @unique_id="1367101866.1996",
                                                @sip_id="SIP/203-0000078c",
                                                @state=nil,
                                                @created_at=2013-04-27 15:31:07 -0700>,
          @created_at=2013-04-27 15:31:07 -0700>
      }

Scripts
-------
The `curses_display` script opens a connection to an Asterisk server, sets up
ChannelObserver and CallObservers that subscribe to events via an
EventListener. The observers maintain lists of current Channels and Calls. A
curses loop renders a pretty list of these Channels and Calls.

`script/curses_display asterisk.example.com 5038 admin secret`

    ----------------------------------------------Channels----------------------------------------------
                    Unique ID                   SIP ID                    State                      Age
    ----------------------------------------------------------------------------------------------------
              1367100883.1993         SIP/501-00000789                       Up                 6.372375
              1367100883.1994         SIP/203-0000078a                       Up                 6.356668
    -----------------------------------------------Calls------------------------------------------------
     Channel 1 Unique ID    Channel 1 SIP ID Channel 2 Unique ID    Channel 2 SIP ID                 Age
    ----------------------------------------------------------------------------------------------------
         1367100883.1993    SIP/501-00000789     1367100883.1994    SIP/203-0000078a            6.140765

Copyright
---------
Copyright (c) 2013 John Wulff. See LICENSE.txt for further details.
