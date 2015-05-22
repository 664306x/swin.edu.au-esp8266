-- Author: Luke Jackson. Swinburne University. 664306x

function w()
  status = wifi.sta.status()
  print("status: "..status)
  if status ~= 5 then
     tmr.alarm(0,500,0,w)
  else
     print(wifi.sta.getip())
  end
end

wifi.setmode(wifi.STATION)
wifi.sta.config("yourssid", "yourpassword")
w()
