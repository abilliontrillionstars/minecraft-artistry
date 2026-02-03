-- modeled after the Ring of Dexterous Motion from botania. --

local lastStep
local sinceLastStep = 0

DashPower = 1

function events.tick()
    sinceLastStep = sinceLastStep+1
end
function events.key_press(key, action, mod)
    --if action==1 then print(key) end
    -- w, a, s, d
    if action==1 and (key==87 or key==65 or key==83 or key==68) and not host:getScreen() then 
        if lastStep == key and sinceLastStep<5 then
            if lastStep==87 then
                pings.playAnim("dashForward")
            elseif lastStep==65 then
                pings.playAnim("dashLeft")
            elseif lastStep==83 then
                pings.playAnim("dashBackward")
            elseif lastStep==68 then
                pings.playAnim("dashRight")
            end
        end
        lastStep = key
        sinceLastStep = 0
    end
end
