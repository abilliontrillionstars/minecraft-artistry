vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
--vanilla_model.ALL:setVisible(false)
models.iris.root:setVisible(true)
models.iris.ItemBrush:setVisible(true)
models.iris.ItemBrush.holdPivot2.handleExtend:setVisible(false)
models.iris.AnimBrush:setVisible(false)
models.iris.AnimBrush.holdPivot.handleExtend:setVisible(false)
models.iris.ItemPalette:setVisible(true)
models.iris.Skull:setVisible(true)
models.iris.Insignia:setVisible(false)

--------------------
--HELPER FUNCTIONS--
--------------------

function pings.playAnim(anim) 
    if animations.iris[anim]:getLoop()=="LOOP" then
      animations.iris[anim]:setPlaying(true)
    else
      animations.iris[anim]:play()
    end
end
function pings.stopAnim(anim) 
    if animations.iris[anim]:getLoop()=="LOOP" then
      animations.iris[anim]:setPlaying(false)
    else
      animations.iris[anim]:stop()
    end
end
function pings.sfx(sound, pitch) 
    if player:isLoaded() then 
      sounds:playSound(sound, player:getPos(), 1, pitch) end 
end
function SetVanillaParent(toggle)
    if toggle then
        models.iris.root.Head:setParentType("Head")
        models.iris.root.Body:setParentType("Body")
        models.iris.root.LeftArm:setParentType("LeftArm")
        models.iris.root.RightArm:setParentType("RightArm")
        models.iris.root.LeftLeg:setParentType("LeftLeg")
        models.iris.root.RightLeg:setParentType("RightLeg")
    else
        models.iris.root.Head:setParentType("None")
        models.iris.root.Body:setParentType("None")
        models.iris.root.LeftArm:setParentType("None")
        models.iris.root.RightArm:setParentType("None")
        models.iris.root.LeftLeg:setParentType("None")
        models.iris.root.RightLeg:setParentType("None")
    end
end

function SendArcana(message, anim, color, load)
    ArcanaString = message .. ":" .. world.getTime()
    pings.playAnim(anim)

    -- cache the arcana
    if load then
        ArcanaCache[color].message = message
        ArcanaCache[color].anim = anim
        pings.ColorFX(color)
    end
end

function AnimsPlaying()
    for _, anim in ipairs(animations:getAnimations()) do
        if anim:isPlaying() then return true end
    end
    return false
end

function HandleLoopAnims()
    if animations.iris["castTwirlStaff1Loop"]:isPlaying() then
        if not MMBDown then
            pings.stopAnim("castTwirlStaff1Loop")
            pings.playAnim("castTwirlStaff1End")
        end
        models.iris.root.LeftArm:setRot(vanilla_model.HEAD:getOriginRot())
        models.iris.root.RightArm:setRot(vanilla_model.HEAD:getOriginRot())
        --gimbal locking,,,,
        --models.iris.AnimBrush:setRot(vanilla_model.HEAD:getOriginRot())
    elseif animations.iris["castForceChokeLoop"]:isPlaying() then
        if not MMBDown then
            pings.stopAnim("castForceChokeLoop")
            pings.playAnim("castForceChokeEnd")
        end
        models.iris.root.LeftArm:setRot(vanilla_model.HEAD:getOriginRot())
        models.iris.root.RightArm:setRot(vanilla_model.HEAD:getOriginRot())
    end
end

sneakKey = keybinds:fromVanilla("key.sneak")
  local wristPocketKey = keybinds:newKeybind("Quick Wristpocket Spell", "key.keyboard.c", false)
  wristPocketKey.press = function() 
    if sneakKey:isPressed() then
      pings.playAnim("castFlickWrist")
    end
end
keybinds:fromVanilla("key.jump").press = function()
    if sneakKey:isPressed() then
        pings.playAnim("jumpSpin")
    end
end


function pings.ColorMain(color)
    models.iris.root.LeftLeg.overall:setColor(color)
    models.iris.root.LeftLeg.overallFlap:setColor(color)
    models.iris.root.RightLeg.overall:setColor(color)
    models.iris.root.RightLeg.overallFlap:setColor(color)
    models.iris.root.Body.overall:setColor(color)

    models.iris.Arrow.cube1:setColor(color)
    models.iris.Arrow.cube2:setColor(color)
    avatar:setColor(color)
    
    if player:isLoaded() then 
        sounds:playSound("minecraft:entity.zombie_villager.converted", player:getPos(), 0.3, 7 + (math.random(-4,4)/10))
        sounds:playSound("minecraft:entity.zombie_villager.converted", player:getPos(), 0.05, 5 + (math.random(-4,4)/10))
    end
    avatar:store("pigment", color)

    PENCOLOR=color
end
function pings.ColorFX(color)
    PENCOLOR_DYE_STRING=color
    PENCOLOR = VANILLA_COLORS[PENCOLOR_DYE_STRING]
end

function pings.updateSkull(palette, pos)
    models.iris.Skull.palette:setVisible(palette)
    if player:isLoaded() then sounds:playSound("spectrum:paintbrush_trigger", player:getPos(), 0.8, 0.5 + math.random()) end
end

function events.key_press(key, action, mod)
    --if action==1 then print(key) end
    -- w, a, s, d
    if action==1 and key==82 and not host:getScreen() and mod==0 and host:getSlot("weapon.mainhand"):getID() == "spectrum:paintbrush" then 
        if BRUSHMODE=="WAND" then
            pings.playAnim("brushToStaff")
        else
            pings.playAnim("brushToWand")
        end
        return true
    end
end

LMBDown = false
RMBDown = false
MMBDown = false
bookOpen = true
function events.mouse_press(button, action)
    if action==1 then
        if button==0 then
            LMBDown = true
        elseif button==1 then
            RMBDown = true
        elseif button==2 then
            MMBDown = true
        end
    else
        if button==0 then
            LMBDown = false
        elseif button==1 then
            RMBDown = false
        elseif button==2 then
            MMBDown = false
        end
    end
    if player:isLoaded() then  
        if player:getHeldItem(true).id:find("spellbook") and player:getHeldItem(false).id == "minecraft:air" then
            if button==1 then
                if action==1 then RMBDown=true
                elseif action==0 then RMBDown=false
                end
            elseif button==0 and action==1 and RMBDown then
                if bookOpen then 
                pings.playAnim("closeSpellbook")
                pings.stopAnim("openSpellbook")
                bookOpen = false
                else 
                pings.playAnim("openSpellbook") 
                pings.stopAnim("closeSpellbook")
                bookOpen = true
                end
            end
        end
    end
end

IsSlinging = false
function events.on_play_sound(id, pos)
    --print(id)
    if id == "spectrum:ink_projectile_launch" then
        --alternate left-right sling arm swing anims
        --don't interrupt the animation immediately after the first sling 
        if animations.iris["slingInk1"]:isPlaying() and animations.iris["slingInk1"]:getTime() > 0.25 then
            pings.stopAnim("slingInk1")    
            pings.playAnim("slingInk2")
        elseif animations.iris["slingInk2"]:isPlaying() then
            pings.stopAnim("slingInk2")    
            pings.playAnim("slingInk1")
        end
    end

    if id == "minecraft:block.sculk_shrieker.shriek" then
        print(pos)
    end
end

--"bs" as shorthand for "brush-shift"
function events.chat_send_message(message)
    return message:gsub(",bs:", ",brush-shift:")
end


local wasDead = false
function events.tick()
    HandleLoopAnims()

    renderer:setRenderLeftArm(player:getHeldItem(true).id == "minecraft:air")

    if player:getDeathTime() > 0 then
        if not wasDead then
            pings.sfx("spectrum:spectrum.ui.new_revelation", 0.85)
            wasDead = true
        end
    else
        wasDead = false
    end
end

hasSpellbook = false
isOnline = false    
function events.skull_render(delta, block, item)
    hasSpellbook = false
    isOnline = false        
    if host:isHost() then
        for i=0,8 do
            if host:getSlot(i):getID() == "hexcasting:spellbook" then
                hasSpellbook = true end
        end
        if host:getSlot(99):getID() == "hexcasting:spellbook" then
                hasSpellbook = true end
    end
    
    if models.iris.Skull.palette:getVisible() == hasSpellbook then
        pings.updateSkull(not hasSpellbook)
    end

    for i,v in pairs(client:getTabList().players) do 
        if v == "just_laniakea" then
            isOnline = true end
    end
    if models.iris.Skull.brush:getVisible() == isOnline then
        models.iris.Skull.brush:setVisible(not isOnline)
        if player:isLoaded() then
            sounds:playSound("spectrum:paintbrush_trigger", player:getPos(), 0.8, math.random(5,13)) end
    end
end

--[[
local checkColor = false
function events.chat_receive_message(message) 
    if message:find("joined the game") then
        checkColor = true
    end
end
function events.tick()
    if player:isLoaded() and checkColor then
        pings.ColorMain(avatar:getColor())
        checkColor = false
    end
end
]]--
