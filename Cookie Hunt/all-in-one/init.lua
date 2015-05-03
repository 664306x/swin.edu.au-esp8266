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
    file.open("index.html", 'r')
    while((line = readline()) ~= nil )
    do
        conn:send(line)
    end
    file.close()
    end) 
end)
