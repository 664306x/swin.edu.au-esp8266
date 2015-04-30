srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive",function(conn,payload) 
    print(payload)
    str = nil

    if string.find(payload,"input=") ~= nil then
		i, j = string.find(payload,"input=")

		temp = (string.gsub(string.sub(payload,j+1), "+", " "))
		
		
		str = unescape(temp)
	end
	
	if str ~= nil then
		cookieset = ('<script>document.cookie="username='..str..'";</script>')
		print (cookieset)
		conn:send(cookieset)
	end
    conn:send('<html><form method="POST" name="smart_house_form" ><p><input type="text" name="input" value="" /></p></form></html>')

    end) 
end)