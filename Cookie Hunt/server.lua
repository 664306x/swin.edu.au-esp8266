-- HTTP server by Edward Francis Gilbert 15 May 2015
-- I have made extensive use of Marcus Kirsch's more functionally
--  complete server at https://github.com/marcoskirsch/nodemcu-httpserver
--  from which the coroutine handling has been copied almost verbatim.

module = {}
    
local sendData = nil
    
print("Now in server.lua")

srv = net.createServer(net.TCP, 10)
print("Created server")
srv:listen(80, function(conn)
    print("Listening on port 80")
    
    local connectionThread

    conn:on("receive", function(conn, request)
        print("on receive called")
        print(request)
        collectgarbage()
        -- search for the file in files
        -- get the name of the requested file
        local i, j
        _, i = string.find(request, 'GET ')
        j, _ = string.find(request, ' HTTP/1.1')
        print(i)
        print(j)
        local filename = string.sub(request, i + 1, j)
        print(filename)
        -- Ensure a request for the root file is properly handled
        if filename == "/" then
            filename = "index.html"
        end
        for k, v in pairs(files) do
            if k == filename then
                local file_etag = files[filename][1] 
                local mime_type = files[filename][2] 
                local filesize_bytes = files[filename][3] 
                break
            end
        end
        if file_etag ~= nil then
            conn.send('HTTP/1.1 200 OK\r\nETag: "' + file_etag + '"\r\nVary: Accept-Encoding\r\n')
            conn.send('Content-Encoding: gzip\r\nContent-Length: ' + filesize_bytes + '\r\nContent-Type: ' + mime_type + '\r\n')
            sendData = dofile('senddata')(file_etag)
            connectionThread = coroutine.create(sendData)
            coroutine.resume(connectionThread, conn, file_etag)
        else
            conn.send('HTTP/1.1 404 Not Found\r\n')
            conn.close()
        end
    end)
    
    conn:on("send", function(conn)
        print("onSent called")
        collectgarbage()
        if connectionThread then
           local connectionThreadStatus = coroutine.status(connectionThread)
           if connectionThreadStatus == "suspended" then
              -- Not finished sending file, resume.
              coroutine.resume(connectionThread)
           elseif connectionThreadStatus == "dead" then
              -- We're done sending file.
              conn:close()
              connectionThread = nil
           end
        end
    end)
end)

return module


