
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
    hue = VANILLA_COLORS[color]
    models.iris.ItemBrush.holdPivot2.physBoneBrushTip:setColor(hue)
    models.iris.AnimBrush.holdPivot.physBoneBrushTip2:setColor(hue)

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

require("script")
local mouseButtons = {"left", "right", "middle", "back", "forward"}
function events.mouse_press(button,action,modifier)
    if action==1 and host:getSlot("weapon.mainhand"):getID() == "spectrum:paintbrush" then
        if modifier~=0 then return false end
        if host:getScreen()~=nil or action_wheel:isEnabled() then return false end
        button = mouseButtons[button+1]

        if ArcanaCache[heldColor][button].message == "" or ArcanaCache[heldColor][button].anim == "" then
            pings.sfx("spectrum:use_fail", math.random(75, 95)/100)
            --print("no arcana for that hue and button")
        else
            SendArcana(ArcanaCache[heldColor][button].message, ArcanaCache[heldColor][button].anim, heldColor) 
            --print("arcana matched, casting...")
            -- special, swap between the slingInk's
            if ArcanaCache[heldColor][button].anim == "castSlingInk1" then
                ArcanaCache[heldColor][button].anim = "castSlingInk2"
            elseif ArcanaCache[heldColor][button].anim == "castSlingInk2" then
                ArcanaCache[heldColor][button].anim = "castSlingInk1" end
        end 
        
        if button=="left" or button=="right" then return true end
    end
end

