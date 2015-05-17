-- HTTP server by Edward Francis Gilbert 15 May 2015
-- I have made extensive use of Marcus Kirsch's more functionally
--  complete server at https://github.com/marcoskirsch/nodemcu-httpserver
--  from which the coroutine handling has been copied almost verbatim.

local module = {}
print("Now in server.lua")

local srv = net.createServer(net.TCP, 10)
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
        filename = string.sub(request, i + 1, j)
        print(filename)
        -- Ensure a request for the root file is properly handled
        _, j = string.find(filename, '/')
        if j == 1 then
            print("yes!")
            filename = "index.html"
        else
            print("no!")
        end
        print(filename)
        for k, v in pairs(files) do
            if k == filename then
                file_etag = files[filename][1] 
                mime_type = files[filename][2] 
                filesize_bytes = files[filename][3] 
                break
            end
        end
        print(file_etag)
        print(mime_type)
        print(filesize_bytes)
        if file_etag ~= nil then
            local file_etag = file_etag
            conn:send('HTTP/1.1 200 OK\r\nETag: "' .. file_etag .. '"\r\nVary: Accept-Encoding\r\n')
            conn:send('Content-Encoding: gzip\r\nContent-Length: ' .. filesize_bytes .. '\r\nContent-Type: ' .. mime_type .. '\r\n')
            sendData = dofile("senddata.lua")
            connectionThread = coroutine.create(sendData(conn, file_etag))
            coroutine.resume(connectionThread)
        else
            conn:send('HTTP/1.1 404 Not Found\r\n')
            conn:close()
        end
    end)
    
    conn:on("sent", function(conn)
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