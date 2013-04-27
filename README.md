asterisk-manager
================
Ruby Gem for connecting to an Asterisk server via the AMI (Asterisk Manager
Interface) protocol.

Scripts
-------
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
