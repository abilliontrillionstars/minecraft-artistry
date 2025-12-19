-- handles animation playing while casting

IsCasting = false
function events.tick()
    if not staff or not spell then return end
    if not player:isLoaded() or player:isCrouching() then return end
    if host:getScreen() then return end
    -- play animation!
    -- e.g. "rootsclassic:chorus"
    name = spell["effect"]
    -- "chorus"
    name = string.sub(name, #"rootsclassic:"+1, #name)
    cast = Spells[name]
    if not cast then return end

    if name ~= oldName then host:setActionbar("§2"..cast["name"]) end
    -- string of anim, e.g. "castWarp"
    anim = cast["anim"]
    if not anim then return end

    if RMBDown then
        -- cancel vanilla bow UseAnim
        if not IsCasting then 
            pings.setCasting(true) 
            cancelBowUseAction(true)
        end
        if not animations.aduene[anim]:isPlaying() then 
            pings.playAnim(anim)
        else
            cancelBowUseAction(true)
        end
        -- special case: show the blink destination (only for caster)
        if name == "chorus" then
            distance = 8 + (8* spell["potency"])
            pos = player:getPos() + (player:getLookDir()*distance)
            if avatar:getRemainingParticles() > 0 then
                particles:newParticle("minecraft:end_rod", pos) end
        end
    else        
        if IsCasting then pings.setCasting(false) end

        if animations.aduene[anim]:isPlaying() then 
            if animations.aduene[anim]:getTime() < 0.6
                then pings.stopAnim(anim) end
        else
            cancelBowUseAction(false)
        end
    end
    oldName = name
end




function pings.setCasting(toggle)
    IsCasting = toggle
end

function cancelBowUseAction(toggle)
    if toggle then
        models.aduene.root.RightArm:setRot(-90,0,0)
        models.aduene.root.LeftArm:setRot(-90,0,0)
        models.aduene.ItemStaff:setRot()
    else
        models.aduene.root.RightArm:setRot()
        models.aduene.root.LeftArm:setRot()
        models.aduene.ItemStaff:setRot(45,0,0)
    end
end

function doBlizzardParticles(clockwise)
    for j=1,4 do 
        for i=1,10 do
            if not player:isLoaded() then return end
            -- from 0 to 1, with some randomness
            i = (i + math.random()-0.5)/10
            -- convert to arc position
            i = i * math.pi * 2
            offset = vec(math.sin(i), j/6, math.cos(i))
            offset = offset * (1.5 + j/4)
            -- add a quarter rotation (with variation)
            i = i + (math.pi / 2) + (j/10)
            -- flip direction by argument 
            if clockwise then i = i + math.pi end
            vel = vec(math.sin(i), 0, math.cos(i))
            particles:newParticle("minecraft:cloud", offset + player:getPos(), vel*0.75)
        end
    end 
end