CHARGE_MODE = "NONE"
CHARGE_TIME = -1

local last_mode = "NONE"
-- what is the leeway time, in ticks, to click both mouse buttons
-- at the same time, setting DUAL?
DualThreshold = 3
function events.tick()
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
    last_mode = CHARGE_MODE
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

    CHARGE_MODE = "NONE"
    CHARGE_TIME = -1
end

function SetState(state)
    CHARGE_MODE = state
    if state == "LEFT" then
        pings.playAnim("chargeLeft")
    elseif state == "RIGHT" then
        pings.playAnim("chargeRight")
    elseif state == "DUAL" then
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