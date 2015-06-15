return function()
    serving = true
    for request in requests do
        local conn = conn
        file_etag = 
        file.open(file_etag)
        conn:send('HTTP/1.1 200 OK\r\nETag: "' .. file_etag .. '"\r\nVary: Accept-Encoding\r\n')
        conn:send('Content-Encoding: gzip\r\nContent-Length: ' .. filesize_bytes .. '\r\nContent-Type: ' .. mime_type .. '\r\n\r\n')
        local stop = false
        local bytesSent = 0
        while stop ~= true do
            file.seek("set", bytesSent)
            local buffer = file.read(256)
            if buffer ~= nil then
                print("buffer")
                conn:send(buffer)
                bytesSent = bytesSent + #buffer
            else
                stop = true
                file.close()
            end
        end
        request[conn] = nil
        conn.close()
        garbagecollect()
    end
    serving = false
end