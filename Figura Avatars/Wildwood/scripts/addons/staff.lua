function events.tick()
    if staff then
        -- charge indicator
        if RMBCharge == 12 then pings.sfx("sounds.Staff percusses", math.random(80,150)/100) end
        if RMBDown then
            if avatar:getRemainingParticles() > 0 and player:isLoaded() then
                for i=1,10 do
                    particles:newParticle("rootsclassic:magic 1", player:getPos(), vec(0,1,0))
                end
            end
        end
    end
end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
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
        host:setActionbar(spell["effect"])
    end
end