vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
models.aduene.root:setVisible(true)

------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.playAnim(anim) 
  if animations.aduene[anim]:getLoop()=="LOOP" then
    animations.aduene[anim]:setPlaying(true)
  else
    animations.aduene[anim]:play()
  end
end
function pings.stopAnim(anim) 
  if animations.aduene[anim]:getLoop()=="LOOP" then
    animations.aduene[anim]:setPlaying(false)
  else
    animations.aduene[anim]:stop()
  end
end
function pings.sfx(sound, pitch) 
  if player:isLoaded() then 
    sounds:playSound(sound, player:getPos(), 1, pitch) end 
end

function AnimsPlaying()
    for _, anim in ipairs(animations:getAnimations()) do
        if anim:isPlaying() then return true end
    end
    return false
end
function OverrideAnimsPlaying()
  for _, anim in ipairs(animations:getAnimations()) do
        if anim:isPlaying() and 
          (anim:getOverrideRot() or anim:getOverridePos() or anim:getOverrideScale()) 
        then return true end
    end
    return false
end

function events.render()
    local origin = vanilla_model.HEAD:getOriginRot()
    if OverrideAnimsPlaying() then
      models.aduene.root.Body.Head:setRot(origin)
    else
      models.aduene.root.Body.Head:setRot(0,0,0)
    end

    --passiveSizeFix
    if (player:isLoaded() and player:getPose()=="STANDING") then
      models.aduene:setScale(1.62/player:getEyeHeight() + 0.25) 
    else 
      --models.aduene:setScale(1.25)
    end
end


local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

events.TICK:register(function ()
    if action_wheel:getCurrentPage() ~= mainPage and not action_wheel:isEnabled()
      then action_wheel:setPage(mainPage) end
end)

mainPage:newAction()
    :title("Toggle Meditate"):item("minecraft:ender_eye")
    :onToggle(function(toggle) 
      animations.aduene.meditateNoSeatLoop:setPlaying(toggle) 
    end)

