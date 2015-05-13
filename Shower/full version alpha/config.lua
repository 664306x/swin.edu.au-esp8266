-- Copyright (c) 2015 by Geekscape Pty. Ltd.  Licence LGPL V3.

local module = {}

module.SSID = {}
module.SSID["jacko"] = "mattisawesome"
module.SSID["jacko2.4"] = "mattisawesome"

module.HOST = "10.1.1.1"
module.PORT = 4000

module.MQTTClientUser  = "user"
module.MQTTClientPassword  = "password"
module.MQTTHost  = "iot.eclipse.org"
module.MQTTPort  = 1883
module.MQTTSecure  = 0

module.Alarm1 = 120
module.Alarm2 = 240
module.Alarm3 = 300

module.debug = true



return module
