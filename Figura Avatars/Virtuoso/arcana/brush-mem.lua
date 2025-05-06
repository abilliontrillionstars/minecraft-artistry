-- cache the last arcana cast by action wheel to a table. each color has its own cache.
ArcanaCache = {
    -- MATTER
    cyan={message="brush-shift:multitool", anim="castSpinRaiseWand"},
    light_blue={message="area:player:night-vision", anim="castInkCross1"},
    blue={message="self-aegis", anim="castInkCross1"},
    lime={message="brush-shift:nature's staff", anim="castSpinRaiseWand"},
    -- TIME
    magenta={message="area:living:slow-time", anim="castStaffOrbit1"},
    pink={message="area:player:heal", anim="castArmsOut2"},
    purple={message="area:player:gate:wheel", anim="castInkCircle1"},
    red={message="area:monster:toss:foo", anim="castSlamStaff1"},
    -- ENERGY
    yellow={message="brush-shift:radiance staff", anim="castSpinRaiseWand"},
    brown={message="brush-shift:monkfruit,32", anim="castArmsIn1"},
    green={message="area:player:gate:home", anim="castInkCircle1"},
    orange={message="area:monster:ignite", anim="castInkCross1"},
    -- VOID
    black={message="", anim=""},
    gray={message="area:item:mediafy:foo", anim="castSpinRaiseWand"},
    light_gray={message="", anim=""},
    white={message="awd", anim="castTwirlStaff1Start"},
}

local heldColor
local oldColor = "white"
function events.tick()
    if host:isHost() then
        if player:getHeldItem():getID() ~= "spectrum:paintbrush" then return end

        heldColor = player:getHeldItem():getTag()["Color"] -- e.g. "spectrum:black"
        if not heldColor then return end
        heldColor = string.sub(heldColor, heldColor:find(":")+1, -1) -- ->"black"

        if oldColor ~= heldColor then
            pings.ColorFX(heldColor)
            oldColor = heldColor
            pings.ColorBrush(heldColor)
        end
    end
end

function pings.ColorBrush(color)
    for var=0,50 do
        if player:isLoaded() and avatar:getRemainingParticles() then
            particles:newParticle("spectrum:"..color.."_crafting", 
              player:getPos()+vec(math.sin(var),0,math.cos(var)), 
              vec(math.random(-50,50)/1000,0.01+math.random()/10,math.random(-50,50)/1000)
            )
        end
    end
    if player:isLoaded() then 
        sounds:playSound("spectrum:spectrum.ui.button_click", player:getPos(), 1)
        sounds:playSound("spectrum:crafting_ding", player:getPos(), 0.2, math.random(8,12)/10)
    end
end

-- eat wasd presses while in the spectrum color selector screen
function events.key_press(key, action)
    if action==1 and (key==87 or key==65 or key==83 or key==68) 
    and host:getScreen() == "de.dafuqs.spectrum.inventories.PaintbrushScreen" 
        then return false end
end


quickcastKey = keybinds:newKeybind("Quickcast via Paintbrush", "key.mouse.middle", false)
quickcastKey.press = function() 
    if ArcanaCache[heldColor].message ~= "" and ArcanaCache[heldColor].anim ~= "" then
        SendArcana(ArcanaCache[heldColor].message, ArcanaCache[heldColor].anim, heldColor) 
        -- special, swap between the slingInk's
        if ArcanaCache[heldColor].anim == "castSlingInk1" then
            ArcanaCache[heldColor].anim = "castSlingInk2"
        elseif ArcanaCache[heldColor].anim == "castSlingInk2" then
            ArcanaCache[heldColor].anim = "castSlingInk1" end
    end 
end


