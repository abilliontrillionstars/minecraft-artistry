vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

SIFTER = ","


function pings.playAnim(anim) 
  if animations.opal[anim]:getLoop()=="LOOP" then
    animations.opal[anim]:setPlaying(true)
  else
    animations.opal[anim]:play()
  end
end
function pings.stopAnim(anim) 
  if animations.opal[anim]:getLoop()=="LOOP" then
    animations.opal[anim]:setPlaying(false)
  else
    animations.opal[anim]:stop()
  end
end
function pings.sfx(sound, pitch) 
  if player:isLoaded() then 
    sounds:playSound(sound, player:getPos(), 1, pitch) end 
end

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

function events.item_render(item, mode)
    local id = item:getID()
    if id:find("bow") then
        return models.opal.ItemBow:setRot(0,0,90)
    end
end

function events.use_item(item, action)
    if action == "BOW" then
        pings.playAnim("bowDraw")
        --pings.playAnim("testBowPoseForward")
    end
end
function events.tick()
    if not RMBDown and (animations.opal["bowDraw"]:isPlaying() or animations.opal["bowDraw"]:getTime() > 0) then
        pings.stopAnim("bowDraw")
        pings.stopAnim("testBowPoseForward")
    end
end

LMBDown = false
RMBDown = false
MMBDown = false
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
end
