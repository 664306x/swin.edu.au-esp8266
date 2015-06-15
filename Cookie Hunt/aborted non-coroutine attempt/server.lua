-- HTTP server by Edward Francis Gilbert 18 May 2015

local module = {}
print("Now in server.lua")

local srv = net.createServer(net.TCP, 10)
print("Created server")
serving = false
srv:listen(80, function(conn)
    print("Listening on port 80")
    conn:on("receive", function(conn, request)
        file_etag = nil
        print("on receive called")
        print(request)
        -- search for the file in files
        -- get the name of the requested file
        local i, j
        _, i = string.find(request, 'GET ')
        j, _ = string.find(request, ' HTTP/1.1')
        print(i)
        print(j)
        filename = string.sub(request, i + 1, j - 1)
        print(filename)
        print(#filename)
        -- Ensure a request for the root file is properly handled
        if #filename == 1 then
            print("yes!")
            filename = "index.html"
        else
            print("no!")
        end
        print(filename)
        for k, v in pairs(files) do
            if k == filename then
                file_etag = files[k][1] 
                local mime_type = files[k][2] 
                local filesize_bytes = files[k][3]
                file.open(file_etag)
                conn:send('HTTP/1.1 200 OK\r\nETag: "' .. file_etag .. '"\r\nVary: Accept-Encoding\r\n')
                conn:send('Content-Encoding: gzip\r\nContent-Length: ' .. filesize_bytes .. '\r\nContent-Type: ' .. mime_type .. '\r\n\r\n')
                requests[conn] = file_etag 
                break
            end
        end
        if file_etag == nil then
            conn:send('HTTP/1.1 404 Not Found\r\n\r\n')
            collectgarbage()
            conn:close()
        end
    end)
    conn:on("sent", function(conn)
        if serving == false then
            serve_requests
        end
end)
return module
