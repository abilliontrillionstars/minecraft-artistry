

function events.on_play_sound(id, pos)
    if player:isLoaded() then
        --replace Hexical evoking noises with beacon powah
        if (pos - player:getPos()):lengthSquared()<1 and id == "hexical:evoking_murmur" then
            sounds:playSound("minecraft:block.beacon.power_select", player:getPos(), 1, 1+(math.random(-20,50)/100))
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