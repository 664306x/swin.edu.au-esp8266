mel = {}
notes = require('notes')
music = require('altmusic')
usage = require('altusage')

i = 1
pwm.setup(pinID, mel[i][1], 512)
pwm.start(pinID)
sustain = 1
tmr.alarm(0,250,1,play)
