-- Author: Luke Jackson. Swinburne University. 664306x

local music = {}

notes = {}
notes['C']={16.35,   32.7,   65.41,  130.8,  261.6,  523.3}
notes['CS']={17.32,  34.65,  69.3,   138.6,  277.2,  554.4}
notes['D']={18.35,   36.71,  73.42,  146.8,  293.7,  587.3}
notes['DS']={19.45,  38.89,  77.78,  155.6,  311.1,  622.3}
notes['E']={20.6,    41.2,   82.41,  164.8,  329.6,  659.3}
notes['F']={21.83,   43.65,  87.31,  174.6,  349.2,  698.5}
notes['FS']={23.12,  46.25,  92.5,   185,    370,    740}
notes['G']={24.5,    49,     98,     196,    392,    784}
notes['GS']={25.96,  51.91,  103.8,  207.7,  415.3,  830.6}
notes['A']={27.5,    55,     110,    220,    440,    880}
notes['AS']={29.14,  58.27,  116.5,  233.1,  466.2,  932.3}
notes['B']={30.87,   61.74,  123.5,  246.9,  493.9,  987.8}
notes['R']={1}--REST  1hz would be inaudiable

mel = {}

pinInd=6

i=1

local function tablelength()
  local count = 0
  for _ in pairs(mel) do count = count + 1 end
  return count
end

function addToMelody(n,octave,time)
	if n  ~= 'C' or n  ~= 'CS' or n  ~= 'D' or n  ~= 'DS' or n  ~= 'E' or n  ~= 'F' or n  ~= 'FS'
	or n  ~= 'G' or n  ~= 'GS' or n  ~= 'A' or n  ~= 'AS' or note  ~= 'B' or note  ~= 'R' then
		return 1
	end
	if octave <1 or octave >9 or octave %1 ~= 0 then
		return 2
	end
	l =tablelength()
	mel[l] = {notes[n][octave], time}
end

function setPWMPin(pinIndex)
	pinInd = pinIndex
end

function clearMelody()
	mel={}
end


function play()
   if i== 16 then
     tmr.stop(0)
     pwm.stop(pinInd)
	 i=1
   end
   print(mel[i])
   pwm.setup(pinInd, mel[i][1], 512)
   pwm.start(pinInd)
   tmr.alarm(0,mel[i][2]*1000,0,n)
   i = i+1
end

return music
