-- handles animation playing while casting

-- notes:
    -- crouch to play the charge-up anim, release to cast
    -- toggle this behavior by crouching straight down/up

local enableCantrips = false

local sneakTicks = 0
function events.tick()
    if player:isLoaded() then
        if player:isCrouching() then
            if sneakTicks == 0 then
                -- rising edge tasks
                if (player:getLookDir() - vec(0,-1,0)):lengthSquared() < 0.001 then
                    -- disable cantrips
                    enableCantrips = false
                end
            end
            sneakTicks = sneakTicks + 1
        else
            if sneakTicks ~= 0 then
                -- falling edge tasks
                if HasStaff and enableCantrips then
                    pings.playAnim("castGust2")
                end
                sneakTicks = 0 

                if (player:getLookDir() - vec(0,1,0)):lengthSquared() < 0.001 then
                    enableCantrips = true
                end
            end
        end
    end
end

local animList = { -- list of overriden animations I want to make
    "idle", "walk", "walkback",
    "jumpup", "jumpdown",
    "walkjumpup", "walkjumpdown",
    "fall",
    "sprint",
    "sprintjumpup", "sprintjumpdown",
    "crouch", "crouchwalk", "crouchwalkback",
    "crouchjumpup", "crouchjumpdown",
    "trident",
    "sleep",
    "swim",
    "sit",
    "death"
}