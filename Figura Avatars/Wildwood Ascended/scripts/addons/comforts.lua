

function events.on_play_sound(id, pos)
    if player:isLoaded() then
        --replace explosions with polite firework booms, or cancel duplicates of them
        if id:find("explode") and host:isHost() then
            sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
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
    end
end