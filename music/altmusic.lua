local module = {}

pinID = 6

function addToMelody(n,octave,time)
    local function checkNote(n)
        for k,_ in pairs(notes) do
            if k == n then
                return true
            end
        end
        return false
    end
    if  not checkNote(n) then
        return false, "not a valid note"
    end
    if octave <1 or octave >9 or octave % 1 ~= 0 then
        return false, "not a valid octave"
    end
    mel[ #mel + 1 ] = {notes[ n ] [ octave ] , time}
end

local function play()
    local time = mel[ i ] [ 2 ] 
    local note = mel[ i ] [ 1 ] 
    if time == sustain then
        i = i + 1
        sustain = 1
    else
        sustain = sustain + 1
    end
    -- play the current note
    pwm.setDuty(pinID, note)
    if i == #mel then
     tmr.stop(0)
     pwm.stop(pinID)
    end
    print('playing')
end

return module
