

function events.on_play_sound(id, pos)
    if player:isLoaded() then
        --replace Hexical evoking noises with beacon powah
        if (pos - player:getPos()):lengthSquared()<1 and id == "hexical:evoking_murmur" then
            sounds:playSound("minecraft:block.beacon.power_select", player:getPos(), 1, 1+(math.random(-20,50)/100))
            return true
        end

        --replace the botania cloak sound, and trigger a countdown
        if (pos - player:getPos()):lengthSquared()<1 and id == "botania:holy_cloak" then
            sounds:playSound("minecraft:block.beacon.deactivate", player:getPos(), 0.6, 2+(math.random(-20,50)/100))
            cloakTimer = 10*20 --ten seconds
            return true
        end


        --replace explosions with polite firework booms, or cancel duplicates of them
        if id:find("explode") and (pos - player:getPos()):lengthSquared() < 32^2 then
            if not watchForSpam then
                sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
            end
            watchForSpam = true
            return true -- we return true here to cancel the sound
        end
    end
end