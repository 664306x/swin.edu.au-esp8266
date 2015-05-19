-- Author: Luke Jackson. Swinburne University. 664306x

tmr.stop(0)

gpio.write(7,gpio.LOW)
gpio.mode(7,gpio.INPUT)
gpio.write(6,gpio.LOW)
gpio.mode(6,gpio.OUTPUT)
pwm.setup(6, 500, 512)

published=false

m = mqtt.Client("client:d5c1-47b3-b65f", 120, "user", "password")
m:lwt("/lwt", "offline", 0, 0)
m:on("connect", function(con) print ("connected") end)
m:on("offline", function(con) print ("offline") end)

m:on("message", function(conn, topic, data)
  print(topic .. ":" )
  if data ~= nil then
    print(data)
  end
end)

function poll()
 a = gpio.read(7)
 print('gpio13: '..a)
 if a==1 then
  if not published then
   pwm.start(6)
   writeToServer('motion detected at: '..tmr.now())
   published=true
  end
 else
  pwm.stop(6)
  published=false
 end
end

function writeToServer(msg)
    --m:connect("iot.eclipse.org", 1883, 0, function(conn) print("connected") end)
    --m:subscribe("/cab309eb-d5c1-47b3-b65f-90056d70d71d",0, function(conn) print("subscribe success") end)
    m:publish("/cab309eb-d5c1-47b3-b65f-90056d70d71d",msg,0,0, function(conn) print("sent") end)
    --m:close();
end

function w()
    print("connected")
    m:subscribe("/cab309eb-d5c1-47b3-b65f-90056d70d71d",0, function(conn) print("subscribe success") end)
    tmr.alarm(0,500,1,poll)
end

m:connect("iot.eclipse.org", 1883, 0, function(conn) w() end)


