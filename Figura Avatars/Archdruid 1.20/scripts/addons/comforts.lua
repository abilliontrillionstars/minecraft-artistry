

function events.on_play_sound(id, pos)
    if player:isLoaded() then
        --replace Hexical evoking noises with beacon powah
        if (pos - player:getPos()):lengthSquared()<1 and id == "hexical:evoking_murmur" then
            sounds:playSound("minecraft:block.beacon.power_select", player:getPos(), 0.5, 1+(math.random(-20,50)/100))
            return true
        end

        --replace explosions with polite firework booms, or cancel duplicates of them
        if id:find("explode") and host:isHost() then
            sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
            return true -- we return true here to cancel the sound
        end
    end
end

function events.chat_send_message(message)
    return message:gsub("-# ", "<dark_gray>-# ")
end


function string.startsWith(str1,str2)
  return str2 == string.sub(str1,1,#str2)
end

function events.CHAT_RECEIVE_MESSAGE(msg,jsonmsg)
  if string.startsWith(msg, "[Rcon:") then
    return false
  end
end

function events.render()
    if host:isHost() then
        renderer:setRenderLeftArm(host:getSlot("weapon.mainhand"):getID() == "minecraft:air")
        renderer:setRenderRightArm(host:getSlot("weapon.offhand"):getID() == "minecraft:air")
    end
end