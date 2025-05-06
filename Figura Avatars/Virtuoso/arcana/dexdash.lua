-- modeled after the Ring of Dexterous Motion from botania. --

local lastStep
local sinceLastStep = 0

function dash(dir)
    local yaw = player.getYRot()
    local x = math.sin(-yaw * 0.017453292 - math.pi)
    local z = math.cos(-yaw * 0.017453292 - math.pi)
    if (dir == Direction.NORTH or dir == Direction.SOUTH) then
        x = math.cos(-yaw * 0.017453292)
        z = math.sin(yaw * 0.017453292)
    end
    local lookVec = vec(x, 0, z);
    
    local y 
    if dir == Direction.WEST or dir == Direction.NORTH then 
        y=1 
    elseif dir == Direction.EAST or dir == Direction.SOUTH then
        y=-1
    else
        y=0
    end
    --local sideVec = lookVec.cross(vec(0, y, 0)*1.25);
    --player.setDeltaMovement(sideVec);
end

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
