mel = {}
notes = require('notes')
music = require('altmusic')

i = 1
addToMelody('B',4, 4)
addToMelody('E',5 , 4)
addToMelody('E',5 , 3)
print(mel)
pwm.setup(pinID, mel[i][1], 512)
pwm.start(pinID)
sustain = 1
tmr.alarm(0,250,1,play)
