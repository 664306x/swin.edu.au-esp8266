cfg={}
cfg.ssid="Cookies2"
cfg.pwd="i<3cookies"
wifi.ap.config(cfg)

wifi.setmode(wifi.SOFTAP)

-- a simple http server
srv=net.createServer(net.TCP, 30) 
    srv:listen(80,function(conn) 
        conn:on("receive",function(conn,data)
        file.open("index.html", 'r')
        stop = false
        while(stop == false)
        do
            line = file.readline()
            if(line ~= nil) then
                conn:send(line)
            else
                stop = true
            end
        end
        file.close()
    end) 
end)
