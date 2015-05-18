local module = {}
local function add_file (filename, file_etag, mime_type, filesize_bytes)
	local file = {}
	module[filename] = file
	module[filename][1] = file_etag
	module[filename][2] = mime_type
	module[filename][3] = filesize_bytes
end
add_file('index.html', 'eacf331f0ffc35d4b482f1d15a887d3', 'text/html', '497')
add_file('cookiemonster.jpg', '3bc98d9d58befa80ddaff4a55565edf', 'image/jpeg', '6789')
add_file('functions.js', '82e686ebecc46c422a9567010c1b446', 'application/javascript', '1385')
add_file = nil
return module
