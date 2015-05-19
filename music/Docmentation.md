##A music Library for ESP8266.

Luke Jackson, 664306x.  
Swinburne University.  

###Aim
To provide an easy to use library that allows people using an ESP8266 chip running the NodeMCU firmware to use the PWM and a speaker to put of melodies. By using the library, people can have their internet of things devices that signal via audio to be more interesting, and useable. 
Features

- Create a monophonic melody from the full western spectrum of music.
- 6 Octaves of range.
- Free timing.
###Example Usage Scenarios
An esp8266 chip is installed in a toaster. When the toast has popped, the ESP8266 plays a fitting melody, such as the Zelda ‘get item’ melody. By using the music library, the Internet of Things toaster is a lot cooler than if it just buzzed.
###Open Issues & Bugs
The library is currently not working because NodeMCU firmware returns with ‘not enough memory’ when the library is used. This is an open issue because the file is only 778 bytes, and NodeMCU should support up to 24k.  
Until this issue is resolved, the library cannot be used.
###Code
Consists of a lua module, which can be used like class in an OOP language.  

```lua
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
	if octave <1 or octave >9 or octave %1 ~= 0
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
```

Figure 1:Music.lua
The library can be used in a user’s application like in figure 2: Usage.lua  

```lua
-- Author: Luke Jackson. Swinburne University. 664306x
music = require("music")
music.addToMelody('B',4, 1)
music.addToMelody('E',5 , 1}
music.addToMelody('E',5 , 0.5}
music.addToMelody('FS',5, 0.5}
music.play()
```

Figure 2:Usage.lua

###API
**addToMelody()**  
Description
Allows the user to add another note to the end of the current melody.
Syntax
addToMelody(n,octave,time)
Parameters
n: the note. Sharp notes are suffixed with an ‘S’.
octave: octave at which to play the note.
Time: The timing for the note (how long it is held for).
Returns
1: The parameter not is not a note (e.g. ‘H’).
2: The octave is outside the range (e.g. -1, 2.5, 10)
Example
music.addToMelody('FS',5, 0.5}

**setPWMPin()**  
Description
Sets the gpio pin to use for PWM
Syntax
setPWMPin(pinIndex)
Parameters
pinIndex: The GPIO pin index to output the PWM.
Returns
nil
Example
~

**play()**  
Description
Plays the current contents of the melody.
Syntax
play()
Parameters
~
Returns
~
Example
Music.play()

**clearMelody()**  
Description
Clears the current contents of the melody.
Syntax
clearMelody()
Parameters
~
Returns
~
Example
~



