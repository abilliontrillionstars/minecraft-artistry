vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.LEFT_ELYTRA:setVisible(false)
vanilla_model.RIGHT_ELYTRA:setVisible(false)


------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.playAnim(anim) animations.miu[anim]:play() end
function pings.stopAnim(anim) animations.miu[anim]:stop() end
function pings.sfx(sound, pitch) 
  if player:isLoaded() then 
    sounds:playSound(sound, player:getPos(), 1, pitch) end 
end

----------------
--- KEYBINDS ---
----------------


-----------------------
--- OTHER FUNCTIONS ---
-----------------------
--pings.playAnim("wingsIdle")
function handleWings()
    if host:isFlying() or player:isGliding() then
        --wing beats for flying
    else
        --wing breathing
    end
end



---------------------
--- ACTION WHEEL  ---
---------------------
mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

---------------------
--- API FUNCTIONS ---
---------------------
function events.render() 
    handleWings() 
end

local lastPos = nil
function events.tick()
    if player:isLoaded() then 
        pos = player:getPos()
        if lastPos ~= nil then
            playerSpeed = (lastPos - pos):length() 
        end
        lastPos = pos
    end
end
