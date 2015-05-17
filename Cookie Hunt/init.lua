cfg = {}
cfg.ssid = "Cookies"
cfg.password = "i<3cookies"
wifi.ap.config(cfg)
cfg = nil
wifi.setmode(wifi.SOFTAP)
print('Attempting connection')
wifi.ap.setip({ip = "10.10.10.10", "255.255.255.0", "0.0.0.0"})
print(wifi.ap.getip())
print("Initialising")
files = require("files")
server = require("server")
