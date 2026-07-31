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

function events.render(delta, context)
  models.aduene.root.Body.Head:setRot(vanilla_model.HEAD:getOriginRot())
end
