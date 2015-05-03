cfg={}
cfg.ssid="Cookies"
cfg.pwd="i<3cookies"
wifi.ap.config(cfg)

wifi.setmode(wifi.SOFTAP)

-- a simple http server
srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive",function(conn,data) 
    print(data) 
    conn:send("<h1> Hello, NodeMCU.</h1>")
    end) 
end)
