return function(conn, args)
    print("sendData called")
    local stop = false
    local bytesSent = 0
    while stop ~= true do
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