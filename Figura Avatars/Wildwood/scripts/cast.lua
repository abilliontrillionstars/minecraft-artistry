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
    -- string of anim, e.g. "castWarp"
    anim = Spells[name]["anim"]
    if not anim then return end

    if RMBDown then
        -- cancel vanilla bow UseAnim
        if not IsCasting then pings.setCasting(true) end
        pings.playAnim(anim)

        -- special case: show the blink destination (only for caster)
        if name == "chorus" then
            host:setActionbar("wah")
            distance = 8 + (8* spell["potency"])
            pos = player:getPos() + (player:getLookDir()*distance)
            if avatar:getRemainingParticles() > 0 then
                particles:newParticle("minecraft:end_rod", pos) end
        end
    else        
        if IsCasting then pings.setCasting(false) end
        if animations.aduene[anim]:getTime() < 0.6 then pings.stopAnim(anim) end
    end
end




function pings.setCasting(toggle)
    IsCasting = toggle
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