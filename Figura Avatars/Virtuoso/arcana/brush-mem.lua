-- cache the last arcana cast by action wheel to a table. each color has its own cache.
ArcanaCache = {
    -- MATTER
    cyan={message="brush-shift:multitool", anim="castSpinRaiseWand"},
    light_blue={message="", anim=""},
    blue={message="self-aegis", anim="castInkCross1"},
    lime={message="brush-shift:natures staff", anim="castSpinRaiseWand"},
    -- TIME
    magenta={message="", anim=""},
    pink={message="area:player:heal", anim="castArmsOut1"},
    purple={message="area:player:gate:wheel", anim="castSpinRaiseWand"},
    red={message="", anim=""},
    -- ENERGY
    yellow={message="brush-shift:radiance staff", anim="castSpinRaiseWand"},
    brown={message="", anim=""},
    green={message="area:player:gate:home", anim="castSpinRaiseWand"},
    orange={message="", anim=""},
    -- VOID
    black={message="", anim=""},
    gray={message="", anim=""},
    light_gray={message="area:item:mediafy:foo", anim="castSpinRaiseWand"},
    white={message="", anim=""},
}

local heldColor
local quickcastKey = keybinds:newKeybind("Quickcast via Paintbrush", "key.mouse.middle", false)
quickcastKey.press = function() 
    if player:isLoaded() then
        if player:getHeldItem():getID() ~= "spectrum:paintbrush" then
            host:setActionbar("Hold your Paintbrush!")
            return
        end
        heldColor = player:getHeldItem():getTag()["Color"] -- e.g. "spectrum:black"
        heldColor = string.sub(heldColor, heldColor:find(":")+1, -1) -- ->"black"
        if ArcanaCache[heldColor].message ~= "" and ArcanaCache[heldColor].anim ~= "" then
            SendArcana(ArcanaCache[heldColor].message, ArcanaCache[heldColor].anim, heldColor) 
            -- special, swap between the slingInk's
            if ArcanaCache[heldColor].anim == "castSlingInk1" then
                ArcanaCache[heldColor].anim = "castSlingInk2"
            elseif ArcanaCache[heldColor].anim == "castSlingInk2" then
                ArcanaCache[heldColor].anim = "castSlingInk1" end
        end 
        --SendArcana()
    end
end


