

function events.on_play_sound(id, pos)
    if player:isLoaded() then
        --replace explosions with polite firework booms, or cancel duplicates of them
        if id:find("explode") and host:isHost() then
            sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
            return true
        end
            --replace casting noises with the staff percussion hit
        if (pos - player:getPos()):lengthSquared()<3 and (id:find("hermes") or id:find("thoth") or id == "hexcasting:casting.cast.spell") then
            sounds:playSound("sounds.Staff percusses", player:getPos(), 1, 1+(math.random(-20,50)/100))
            return true
        end
    end

end

function events.chat_send_message(message)
    return message:gsub("-# ", "<dark_gray>-# ")
end


function events.render()
    if host:isHost() then
        renderer:setRenderLeftArm(host:getSlot("weapon.mainhand"):getID() == "minecraft:air")
        renderer:setRenderRightArm(host:getSlot("weapon.offhand"):getID() == "minecraft:air")
        local anims = animations:getPlaying()[1]
        renderer:setForcePaperdoll(anims)
    end
end