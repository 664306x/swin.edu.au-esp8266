local answer 	-- declaring a local variable, there is NO TYPING IN LUA (btw this is a comment :) )
local t = {}	-- table type, probably lua most strong type
t["astring"] = 3
t[4] = "astring"	--but its got no typing

s ={}
s[true] = 1
s[false] = 0
switch = false
repeat 							-- do while syntax
   print(s[switch])
   switch = not switch						-- not syntax
   io.write("continue with this operation (y/n)? ")	--take user input
   io.flush()
   answer=io.read()					--take user input step 2
until answer=="n"			--the while condition