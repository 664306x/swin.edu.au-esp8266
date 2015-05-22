--Simple web server for the ESP8266, for turning an LED on and off
--Author: Edward Francis Gilbert  Date: Sunday 10 May 2015

function checkWiFiStatus()
  local s = wifi.sta.status()
  print("WiFi Status: " .. s) 
  if s == 5 then
    tmr.stop(0)
    print("Connected on " .. wifi.sta.getip())
  end
end

wifi.setmode(wifi.STATION)
wifi.sta.config("ssid", "password")
print('Attempting connection')
wifi.sta.connect()
tmr.alarm(0, 1000, 1, checkWifiStatus)

gpio.mode(3, gpio.OUTPUT)

srv=net.createServer(net.TCP, 3)
    print("Server created on " .. wifi.sta.getip())
srv:listen(80,function(conn)
    conn:on("receive",function(conn,request)
    print(request)
    _, j = string.find(request, 'led_light_switch=')
    if j ~= nil then
        command = string.sub(request, j + 1)
            if command == 'on' then
                gpio.write(3, gpio.HIGH)
            else
                gpio.write(3, gpio.LOW)
            end
    else
        -- Start off with the light off
        -- Without this, the light will show as on when it is off at first
        gpio.write(3, gpio.LOW)
    end
    conn:send('<!DOCTYPE html>')
    conn:send('<html lang="en">')
    conn:send('<head><meta charset="utf-8" />')
    conn:send('<title>Hello, World!</title></head>')
    conn:send('<body><h1>Hello, World!</h1>')
    -- Send the current status of the LED
    if gpio.read(3) == gpio.HIGH then
        led = "ON"
    else
        led = "OFF"
    end
    conn:send('<p>The light is ' .. led .. '</p>')
    conn:send('<form method="post">')
    conn:send('<input type="radio" name="led_light_switch" value="on">ON</input><br />')
    conn:send('<input type="radio" name="led_light_switch" value="off">OFF</input><br />')
    conn:send('<input type="submit" value="Light Switch" />')
    conn:send('</form></body></html>')
    end)
end)
