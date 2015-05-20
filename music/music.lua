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

local function validNote(n)
    for k in pairs(notes.notes) do
	   if k == n then
	       return true
	   end
    end
	return false
end

function module.addToMelody(n,octave,time,dynamics)
	if validNote(n) == false then
		return 1
    end
	if octave <1 or octave >6 or octave %1 ~= 0 then
		return 2
	end
	if time <1 or time >8 or time %1 ~=0 then
	    return 3
    end
	if dynamics<0 or dynamics > 1023 or dynamics %1 ~=0 then
	    return 4
    end

	l =tablelength()
	mel[l+1] = {notes.notes[n][octave], time,dynamics}
   print('inserted '..mel[l+1][1]..'hz at position: '..l+1)
   return 0
end

function module.printMelody()
    l = tablelength()
	for i=1,l,1 do
		--print(' '..i..': '..mel[i][1]..'hz, timing: '..mel[i][2]..', dynamics: '..mel[i][3])
      print(i)
      print(mel[i][1])
      print(mel[i][2])
      print(mel[i][3])
      print('---')
	end
end

function module.setPWMPin(pinIndex)
	pinInd = pinIndex
end

function module.clearMelody()
	mel={}
end

function setTempo(ptempo)
  if tempo <0 then
	return 1
  end
  tempo = ptempo
end

function module.play()
   if i > tablelength() then
     tmr.stop(0)
     pwm.stop(pinInd)
	 i=1
     return
   end

   pwm.stop(pinInd)
   pwm.setup(pinInd, mel[i][1], mel[i][3])
   pwm.start(pinInd)
   print('playing: '..mel[i][1]..'for: '..mel[i][2]*tempo..'ms')
   tmr.alarm(0,mel[i][2]*tempo,0,module.play)
   i = i+1
end

return module
