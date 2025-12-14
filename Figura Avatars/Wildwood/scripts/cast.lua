-- handles animation playing while casting

function events.tick()
    if not staff or not spell or not RMBDown then return end
    -- debug
    if world.getTime() % 10 ~= 0 then return end
    -- play animation!
    -- e.g. "rootsclassic:chorus"
    name = spell["effect"]
    -- "chorus"
    name = string.sub(name, #"rootsclassic:"+1, #name)
    -- string of anim, e.g. "castWarp"
    anim = Spells[name]["anim"]
    if not anim then return end
end
