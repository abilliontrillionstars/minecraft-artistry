
-- during-use effects
function events.tick()
    if staff and player:isLoaded() then
        if player:isCrouching() then return end
        -- charge indicator
        blips = {0, 3, 6, 8, 10, 12}
        for i in pairs(blips) do 
            if RMBCharge == blips[i] then
                sounds:playSound("block.note_block.hat", player:getPos(), 0.2, 1)
                sounds:playSound("block.note_block.hat", player:getPos(), 0.2, 0.8)
            end
        end
        if RMBCharge == 12 then pings.sfx("sounds.Staff percusses", math.random(8,12)/10) end
        
        -- particles
        if IsCasting then
            for var=0,5 do
                if avatar:getRemainingParticles() > 50 then
                    i = math.random() * math.pi * 2
                    offset = vec(math.sin(i), 0, math.cos(i))
                    particles:newParticle("minecraft:end_rod", player:getPos()+offset, vec(0,0.01,0))
                end
            end
        end
    end

    --if host:isHost() then host:setActionbar(player:getVelocity().xz:length()) end
end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
    if host:isHost() then
        offhand = host:getSlot("weapon.offhand")
        mainhand = host:getSlot("weapon.mainhand")
        
        --offhand authoritative
        staff = nil
        if offhand:getID() == "rootsclassic:crystal_staff" then
            staff = offhand
        elseif mainhand:getID() == "rootsclassic:crystal_staff" then
            staff = mainhand
        end

        if staff then
            i = staff.tag["rootsclassic:selected"]
            spell = staff.tag["rootsclassic:spells"]["spellList"][i]
            --host:setActionbar(spell["effect"])
        end
    end
end


function events.item_render(item, mode)
    local id = item:getID()
    if id == "rootsclassic:crystal_staff" then
        if mode:find("THIRD") then
            return models.aduene.ItemStaff:setPos(0,0,1)        
        else
            model = models.aduene.ItemStaff:setRot(0,90,0)
            if staff and RMBDown and not player:isCrouching() then model:setRot(0,90,15) end
            return model
        end
    end
end


