###API
**addToMelody()**  
_Description_  
Allows the user to add another note to the end of the current melody.

_Syntax_  
addToMelody(n,octave,time, dynamics)

_Parameters_
n: the note. Sharp notes are suffixed with an ‘S’.
octave: 1-6 integer, octave at which to play the note.
Time: 1-8 integer, The timing for the note (how long it is held for).
Dynamics: 1-1023, controls volume of the note.

_Returns_  
0: success input
1: The parameter not is not a note (e.g. ‘H’).
2: The octave is outside the range (e.g. -1, 2.5, 10)
3: Invalid timing (sould be 1-8 integer)
4: invalid dynamics (should be 1-1023 integer)

_Example_  
music.addToMelody('FS',5, 1,512}

***

**setPWMPin()**  
_Description_  
Sets the gpio pin to use for PWM

_Syntax_  
setPWMPin(pinIndex)

_Parameters_  
pinIndex: The GPIO pin index to output the PWM.

_Returns_  
nil

_Example_  
~

***

**play()**  
_Description_  
Plays the current contents of the melody.

_Syntax_  
play()

_Parameters_  
~

_Returns_  
~

_Example_  
Music.play()

***

**clearMelody()**  
_Description_  
Clears the current contents of the melody.

_Syntax_  
clearMelody()

_Parameters_  
~

_Returns_  
~

_Example_  
~

***

**module.printMelody()**
_Description_  
prints the current contents of the melody.

_Syntax_  
printMelody()

_Parameters_  
~

_Returns_  
~

_Example_    
music.printMelody()  
output example  
```
1    --the notes position
C   -- the note
4   -- the notes timing
512 -- the notes volume
'---' -- end of note
2   -- the notes position
--etc.
```

***

**setTempo()**
_Description_  
Sets the tempo to play melody at. 'timing' is multiplied by this number. Thus with a tempo 250,

- note timing 1: 250ms
- note timing 2: 500ms
- etc.

_Syntax_  
setTempo(ptempo)

_Parameters_  
ptempo: an integer, it is the tempo

_Returns_  
~

_Example_   
~

***
