-- Author: Luke Jackson. Swinburne University. 664306x

local module = {}

local mel = {}
local pinInd=6
local i=1
local tempo=250

local function tablelength()
  local count = 0
  for _ in pairs(mel) do count = count + 1 end
  return count
end

function module.addToMelody(n,octave,time)
	if octave <1 or octave >9 or octave %1 ~= 0 then
		return 2
	end
	l =tablelength()
	mel[l+1] = {notes.notes[n][octave], time}
   print('inserted '..mel[l+1][1]..'hz at position: '..l)
   return true
end

function module.setPWMPin(pinIndex)
	pinInd = pinIndex
end

function module.clearMelody()
	mel={}
end

function module.play()
   if i > tablelength() then
     tmr.stop(0)
     pwm.stop(pinInd)
	 i=1
     return
   end

   pwm.stop(pinInd)
   pwm.setup(pinInd, mel[i][1], 256)
   pwm.start(pinInd)
   print('playing: '..mel[i][1]..'for: '..mel[i][2]*tempo..'ms')
   tmr.alarm(0,mel[i][2]*tempo,0,module.play)
   i = i+1
end

return module
