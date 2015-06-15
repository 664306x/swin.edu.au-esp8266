local module = {}

srv = net.createServer(net.TCP)
srv.listen(80, function(conn)
    conn:on('receive', function(conn, request)
        print(request)
        file.open('index.html', 'r')
        while finished ~= true do
            line = file.readline()
            if line ~= nil then
                conn:send(line)
            else
                finished = true
                file.close()
            end
        end
    end)
end)

return module
