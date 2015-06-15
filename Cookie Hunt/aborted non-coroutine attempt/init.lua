cfg={}
cfg.ssid="ssid"
cfg.pwd="password"
cfg = nil
wifi.ap.config(cfg)
wifi.setmode(wifi.SOFTAP)
print('Attempting connection')
wifi.ap.setip({ip = "10.10.10.10", "255.255.255.0", "0.0.0.0"})
print(wifi.ap.getip())
print("Initialising")
files = require("files")
requests = {}
serving = false
httpserv = require("server")
serve_requests = require("serve_requests")
