wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","PASSWORD")

file.open("output.lua", "w")
file.writeline("WebIDE Start")
file.close()

print(wifi.getmode())
print(wifi.sta.getip())



srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive",function(conn,payload) 
    --print(payload)
    if string.find(payload,"input=") ~= nil then
		i, j = string.find(payload,"input=")

		endInput = string.find(payload,"&sub=Submit")
		temp = (string.gsub(string.sub(payload,j+1,endInput-1), "+", " "))

		str = unescape(temp)
		--print ("This is the working part: "..str)

		file.remove("input.lua")
		file.open("input.lua","w")
		file.writeline(str)
		file.close()

		outputFile(str)
		dofile("input.lua")

		--string.sub(payload,j+1)
	end
    --conn:send('<html><form method="POST" name="smart_house_form" ><p><input type="text" name="input" value="" /></p></form></html>')
	--conn:send('<html><form method="POST" name="smart_house_form" ><p><input type="submit" name="sub" value="Submit" /></br><textarea name="input" rows="4" cols="50"></textarea></p></form></html>')
	
	file.open("output.lua", "r")
	temp = ""
	repeat
		line=file.readline()
		if line ~= nil and line ~= "> \n" and line ~= "\n" then
			temp =temp..'<br>'.."> "..line
		end
		until not line
    file.close()

	
	conn:send('<html><form method="POST" name="smart_house_form" ><p><p>'..temp..'</p><textarea name="input" rows="4" cols="50"></textarea></br><input type="submit" name="sub" value="Submit" /></p></form></html>')
	temp = nil

    end) 
end)

function hex_to_char(x) --converts hex to char. returns char
		return string.char(tonumber(x, 16))
    end

function unescape(url) --Unescapes html charcters for ease of use. returns a string
		output = url:gsub("%%(%x%x)", hex_to_char)
		return output
    end

function outputFile(str) --prints string to output file. takes in string. used for node.output(outputFile, 1)
		file.open("output.lua","a")
		file.writeline(str)
		file.close()
    end