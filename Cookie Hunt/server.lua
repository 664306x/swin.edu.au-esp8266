-- HTTP server by Edward Francis Gilbert 15 May 2015
-- I have made extensive use of Marcus Kirsch's more functionally
--  complete server at https://github.com/marcoskirsch/nodemcu-httpserver
--  from which the coroutine handling has been copied almost verbatim.

module = {}

function module.start()
    
    local connectionThread
    
    srv = net.createServer(net.TCP, 10) 
    srv:listen(80,function(conn)
    
        local function sendData()
            local stop = false
            local bytesSent = 0
            while stop == false do
                collectgarbage()
                file.open(file_etag)
                file.seek("set", bytesSent)
                local buffer = file.read(256)
                file.close()
                if buffer ~= nil then
                    coroutine.yield()
                    conn:send(buffer)
                    bytesSent = bytesSent + #buffer
                else
                    stop = true
                end
            end
        end
                
        local function onReceive(conn,request)
            print(request)
            collectgarbage()
            -- search for the file in files
            -- get the name of the requested file
            local i, j
            _, i = string.find(request, 'GET ')
            j, _ = string.find(request, ' HTTP/1.1\r\n')
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
                connectionThread = coroutine.create(sendData)
                coroutine.resume(connectionThread, conn)
            else
                conn.send('HTTP/1.1 404 Not Found\r\n')
                conn.close()
            end
            
        end
        
        local function onSent(conn, data)
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
         end
        
        conn:on("receive", onReceive)
        conn:on("send", onSent)

    end)
return srv
end

return module


