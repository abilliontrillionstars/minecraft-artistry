vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.LEFT_ELYTRA:setVisible(false)
vanilla_model.RIGHT_ELYTRA:setVisible(false)

--predicate state for whether the 'butterfly form' is active
EMPOWERED = false
--string psuedo-enum for which 'mode' moon's magic is in
--current possible modes are BOLTS, MINING, and PROTECT
SPELL_MODE = "BOLTS"

------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.playAnim(anim) animations.moon[anim]:play() end
function pings.stopAnim(anim) animations.moon[anim]:stop() end

----------------
--- KEYBINDS ---
----------------
keybinds:newKeybind("Open Wings", "key.mouse.5").press = function() if next(animations:getPlaying()) == nil then pings.playAnim("wingsOut1") end end
keybinds:newKeybind("Close Wings", "key.mouse.4").press = function() if next(animations:getPlaying()) == nil then pings.playAnim("wingsIn1") end end
local boostKey = keybinds:newKeybind("Elytra Boost", "key.keyboard.left.control")
local chargeKey = keybinds:newKeybind("Charge Key", "key.mouse.3")

-----------------------
--- OTHER FUNCTIONS ---
-----------------------
local isBoosting = false
function handleWings()
    if host:isFlying() or player:isGliding() then
        --wing beats for flying
        models.moon.Body.WingL:setRot(0,-10+ math.sin(world.getTime()) * 15,0)
        models.moon.Body.WingR:setRot(0,10+ math.sin(world.getTime()) * -15,0)
        --oh also if the wings aren't open, open them
        if not EMPOWERED then pings.playAnim("wingsOut1") end
    else
        --wing breathing
        models.moon.Body.WingL:setRot(0,-10+ math.sin(world.getTime() / 25) * 4,0)
        models.moon.Body.WingR:setRot(0,10+ math.sin(world.getTime() / 25) * -4,0)
    end
    --kind of scope creepy but wtv
    --process hex-powered elytra thrust
    
    if boostKey:isPressed() then
        if not isBoosting and player:isGliding() then 
            host:sendChatMessage("!boostcont0") 
            isBoosting = true 
        end
    else
        if isBoosting then 
            host:sendChatMessage("!") 
            isBoosting = false
        end
    end
end

cTicks = 0
function handleCharging()
    if chargeKey:isPressed() then
        --increment the time charged
        cTicks = cTicks + 1

        --choose the charging animation
        if SPELL_MODE == "BOLTS" or SPELL_MODE == "MINING" then 
            if next(animations:getPlaying()) == nil then pings.playAnim("charge1start") end
        elseif SPELL_MODE == "PROTECT" then
            if next(animations:getPlaying()) == nil and EMPOWERED then pings.playAnim("shieldstart") end
        end
        --play sounds indicating charging thresholds
        if not EMPOWERED then 
            if SPELL_MODE == "BOLTS" and cTicks%10 == 0 and player:isLoaded() then
                if cTicks < 90 then 
                    sounds:playSound("block.amethyst_block.place", player:getPos(), 0.4, 1)
                elseif cTicks == 90 then
                    sounds:playSound("block.amethyst_cluster.break", player:getPos(), 1, 1.8)     
                end
            elseif SPELL_MODE == "MINING" and cTicks%20 == 0 and player:isLoaded() then
                if cTicks < 180 then 
                    sounds:playSound("block.amethyst_block.place", player:getPos(), 0.4, 1) 
                elseif cTicks == 180 then                 
                    sounds:playSound("block.amethyst_cluster.break", player:getPos(), 1, 1.3)
                end
            end
        elseif EMPOWERED then
            if SPELL_MODE == "BOLTS" and cTicks%15 == 0 and player:isLoaded() then
                if cTicks < 135 then 
                    sounds:playSound("block.amethyst_block.place", player:getPos(), 0.4, 0.9) 
                elseif cTicks == 135 then
                    sounds:playSound("block.amethyst_cluster.break", player:getPos(), 1, 1.2)    
                end
            elseif SPELL_MODE == "MINING" and cTicks%20 == 0 and player:isLoaded() then
                if cTicks < 180 then 
                    sounds:playSound("block.amethyst_block.place", player:getPos(), 0.4, 0.9) 
                elseif cTicks == 180 then
                    sounds:playSound("block.amethyst_cluster.break", player:getPos(), 1, 1)
                end
            end
        end
    else
        --show how long we charged for
        --if cTicks~=0 then host:setActionbar("§bTicks Charged: §3"..cTicks) end

        --stop or progress any charging animations
        if animations.moon.charge1loop:isPlaying() then
            pings.stopAnim("charge1loop")
            pings.playAnim("charge1shoot")
        elseif animations.moon.charge1start:isPlaying() then
            pings.stopAnim("charge1start")
            pings.playAnim("charge1shoot")
        elseif animations.moon.shieldstart:isPlaying() then
            pings.stopAnim("shieldstart")
            pings.playAnim("shieldshoot")
        elseif animations.moon.shieldloop:isPlaying() then
            pings.stopAnim("shieldloop")
            pings.playAnim("shieldshoot")
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
mainPage:newAction()
    :hoverColor(vectors.hexToRGB("406797"))
    :item("minecraft:shield")
    :title("PROTECT")
    :onLeftClick(function() changeSpellType("PROTECT") end)

---------------------
--- API FUNCTIONS ---
---------------------
function events.tick()
    handleWings()
    --force-render the offhand if it's empty
    renderer:setRenderLeftArm(player:getHeldItem(true).id == "minecraft:air")
    handleCharging()
end

function events.on_play_sound(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those

    --replace explosions with polite firework booms
    if path and id:find("explode") and (pos - player:getPos()):lengthSquared() < 32^2 then
        sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
        return true
    end
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

