CHARGE_MODE = "NONE"
CHARGE_TIME = -1
DISABLE_WASD = false

local last_mode = "NONE"
-- what is the leeway time, in ticks, to click both mouse buttons
-- at the same time, setting DUAL?
DualThreshold = 3
function RunState()
    -- lock the charging mode
    if CHARGE_TIME==-1 then
        if RMBDown and LMBDown 
        and RMBCharge<DualThreshold and LMBCharge<DualThreshold then
            SetState("DUAL")
        elseif MMBDown then
            SetState("MIDDLE")
        elseif RMBDown then
            SetState("RIGHT")
        elseif LMBDown then
            SetState("LEFT")
        end 
        if CHARGE_MODE~="NONE" then CHARGE_TIME = CHARGE_TIME+1 end
    else -- tend the charging mode
        if CHARGE_MODE == "RIGHT" or CHARGE_MODE == "LEFT" then
            if RMBDown and LMBDown 
            and RMBCharge<DualThreshold and LMBCharge<DualThreshold then
                SetState("DUAL") end
        end

        if CHARGE_MODE == "MIDDLE" 
        and not MMBDown then
            ReleaseCharge()
        elseif CHARGE_MODE == "RIGHT"
        and not RMBDown then
            ReleaseCharge()
        elseif CHARGE_MODE == "LEFT"
        and not LMBDown then
            ReleaseCharge()
        elseif CHARGE_MODE == "DUAL" 
        and (not RMBDown or not LMBDown) then
            ReleaseCharge()
        end
        if CHARGE_MODE~="NONE" then CHARGE_TIME = CHARGE_TIME+1 end
    end
end

function ReleaseCharge()
    --print("("..CHARGE_MODE.." : "..CHARGE_TIME..")")
    -- advance running animations
    local running = animations:getPlaying()
    --printTable(running)
    for i, anim in ipairs(running) do
        anim = anim:getName()
        pings.stopAnim(anim)
        local next = NextAnim(anim)
        if next then pings.playAnim(next) end
    end
    DISABLE_WASD = false
    CHARGE_MODE = "NONE"
    CHARGE_TIME = -1
end

function SetState(state)
    CHARGE_MODE = state
    if state == "LEFT" 
    and host:getSlot("weapon.mainhand"):getID() == "minecraft:air" then
        pings.playAnim("chargeLeft")
    elseif state == "RIGHT" 
    and host:getSlot("weapon.offhand"):getID() == "minecraft:air" then
        pings.playAnim("chargeRight")
    elseif state == "DUAL" 
    and host:getSlot("weapon.offhand"):getID() == "minecraft:air"
    and host:getSlot("weapon.mainhand"):getID() == "minecraft:air" then
        pings.stopAnim("chargeLeft")
        pings.stopAnim("chargeRight")

        pings.playAnim("chargeCastDual1Start")
    end
end

function NextAnim(anim)
    if anim == "chargeLeft" then return "chargeCastLeft"
    elseif anim == "chargeRight" then return "chargeCastRight"
    elseif anim == "chargeCastDual1Loop" then return "chargeCastDual1End"
    end
end


-- eat wasd if an animation requires standing still
function events.key_press(key, action)
    if (action==1 or action==2) and (key==87 or key==65 or key==83 or key==68) 
    and DISABLE_WASD then return true end
end
