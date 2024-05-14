-- Auto generated script file --
vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.LEFT_ELYTRA:setVisible(false)
vanilla_model.RIGHT_ELYTRA:setVisible(false)

--predicate state for whether the 'butterfly form' is active
EMPOWERED = false
--string psuedo-enum for which 'mode' moon's magic is in
--current modes are BOLTS, MINING, and PROTECT
SPELL_MODE = "BOLTS"

------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.wingsOut1() animations.moon.wingsOut1:play() end
function pings.wingsIn1() animations.moon.wingsIn1:play() end
function pings.charge1() animations.moon.charge1start:play() end
function pings.charge2() animations.moon.charge2start:play() end

----------------
--- KEYBINDS ---
----------------
keybinds:newKeybind("Open Wings", "key.mouse.5").press = pings.wingsOut1
keybinds:newKeybind("Close Wings", "key.mouse.4").press = pings.wingsIn1
local chargeKey = keybinds:newKeybind("Charge Key", "key.mouse.3")

-----------------------
--- OTHER FUNCTIONS ---
-----------------------
function handleWings()
    if host:isFlying() or player:isGliding() then
        --wing beats for flying
        models.moon.Body.WingL:setRot(0,-10+ math.sin(world.getTime()) * 15,0)
        models.moon.Body.WingR:setRot(0,10+ math.sin(world.getTime()) * -15,0)
        --oh also if the wings aren't open, open them
        if not EMPOWERED then pings.wingsOut1() end
    else
        --wing breathing
        models.moon.Body.WingL:setRot(0,-10+ math.sin(world.getTime() / 25) * 4,0)
        models.moon.Body.WingR:setRot(0,10+ math.sin(world.getTime() / 25) * -4,0)
    end
end

cTicks = 0
function handleCharging()
    if chargeKey:isPressed() then
        cTicks = cTicks + 1
        
        if not EMPOWERED then 
            if SPELL_MODE == "BOLTS" and cTicks%10 == 0 and player:isLoaded() then
                if cTicks >= 90 then 
                    sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.01, 1.8, false)
                else    
                    sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.01, 0.8, false) 
                end
            elseif SPELL_MODE == "MINING" and cTicks%20 == 0 and player:isLoaded() then
                if cTicks >= 180 then 
                    sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.01, 1.5, false)
                else    
                    sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.01, 0.8, false) 
                end
            end
            if next(animations:getPlaying()) == nil then pings.charge1() end
        elseif EMPOWERED then
            if SPELL_MODE == "BOLTS" and cTicks%20 == 0 and player:isLoaded() then
                if cTicks >= 180 then 
                    sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.01, 1.9, false)
                else    
                    sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.01, 0.7, false) 
                end
            elseif SPELL_MODE == "MINING" and cTicks%20 == 0 and player:isLoaded() then
                if cTicks >= 180 then 
                    sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.01, 1.6, false)
                else    
                    sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 0.01, 0.6, false) 
                end
            end
            if next(animations:getPlaying()) == nil then pings.charge2() end
        end
    else
        --debug: show how long we charged
        if cTicks~=0 then host:setActionbar("§bTicks Charged: §3"..cTicks) end

        if animations.moon.charge1loop:isPlaying() then
            animations.moon.charge1loop:stop()
            animations.moon.charge1shoot:play()
        elseif animations.moon.charge1start:isPlaying() then
            animations.moon.charge1start:stop()
            animations.moon.charge1shoot:play()
        elseif animations.moon.charge2loop:isPlaying() then
            animations.moon.charge2loop:stop()
            animations.moon.charge2shoot:play()
        elseif animations.moon.charge2start:isPlaying() then
            animations.moon.charge2start:stop()
            animations.moon.charge2shoot:play()
        end
    end
end

function changeSpellType(state) --TODO
    --change HUD elements
    host:setActionbar("Switched Spell State to "..state)
    --lastly change the actual state
    SPELL_MODE = state
end


---------------------
--- ACTION WHEEL  ---
---------------------
mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
mainPage:newAction()
    :hoverColor(vectors.hexToRGB("406797"))
    :item("minecraft:cracked_stone_bricks")
    :title("MINING")
    :onLeftClick(function() changeSpellType("MINING") end)
mainPage:newAction()
    :hoverColor(vectors.hexToRGB("406797"))
    :item("minecraft:crossbow")
    :title("BOLTS")
    :onLeftClick(function() changeSpellType("BOLTS") end)

---------------------
--- API FUNCTIONS ---
---------------------
function events.tick()
    handleWings()
    --force-render the offhand if it's empty
    renderer:setRenderLeftArm(player:getHeldItem(true).id == "minecraft:air")
    handleCharging()
end

function events.ON_PLAY_SOUND(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those

    --replace explosions with polite firework booms
    if path and id:find("explode") and (pos - player:getPos()):lengthSquared() < 32 then
        sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
        return true
    end
end

local lastMessage = ""
function events.CHAT_SEND_MESSAGE(message)
    --prevent duplicate hexcasting signals
    if (string.sub(message, 1, 1) == "!") and (lastMessage == message) then return end

    lastMessage = message
    return message
end


--unused, I'm putting off getting extruded textures to scale well in bb
--[[
local swordIDs = {"minecraft:iron_sword", "iron_sword"}
function events.item_render(item, context)
    for i=1,#swordIDs do
        if swordIDs[i] == item.id then
            return models.moon.ItemSword
        end
    end
end
]]--

