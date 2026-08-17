vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
models.aduene.root:setVisible(true)
animations.aduene["passiveSizeFix"]:play()

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
end



-- patch: stop the walk animation if I'm not pressing w --
local wPressed = false
function events.key_press(key, action)
  if key==87 then 
    if action==0 then
      pings.updateWPressed(false)
    elseif action==1 then
      pings.updateWPressed(true)
    end
  end
end
function pings.updateWPressed(toggle) wPressed = toggle end
function events.render(delta, context)
  if not wPressed and animations.aduene.walk:isPlaying() then
    -- var in jimmyanims
    walking = false
  end
end
