--[[

--set up our piano
piano_lib  =  world.avatarVars()["b0e11a12-eada-4f28-bb70-eb8903219fe5"]
local pianoPos = "{-81, 78, 137}"

-- set up our playing ping
function pings.playKey(note)
    piano_lib.playNote(pianoPos, note, true)
end

--whether or not we'll cancel keybinds to play piano notes
PlayingMode = false
--our current octave offset
OctaveOffset = 0
local octVA = keybinds:newKeybind("Increase Octave", "key.keyboard.right")
octVA.press = function()
    if OctaveOffset < 3 then
        OctaveOffset = OctaveOffset+1 end
end
local octVb = keybinds:newKeybind("Increase Octave", "key.keyboard.right")
octVA.press = function()
    if OctaveOffset > 1 then
        OctaveOffset = OctaveOffset-1 end
end

local exampleKey = keybinds:newKeybind("Piano Key C1", "key.keyboard.z")
exampleKey.press = function() 
    pings.playKey("C"..OctaveOffset) return PlayingMode
end

]]--