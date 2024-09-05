if client.getVersion() == "1.19.2" then
    spellPage = action_wheel:newPage()
    

    SkySoarer = {
        name="Sky Soarer", id="skysoarer",
        hue1="20c8ff", hue2="2040ff",
        nick="§3S§1S", poseAnim="", 
        mods={
            1, --strength (magnitude multiplier)
            0 -- regenerative sky
        } 
    }
    ModPageSS = action_wheel:newPage()
    --Sky Soarer Modifiers--
    ModPageSS:newAction()
        :item("minecraft:white_wool"):title("Low Velocity")
        :onLeftClick(function() SkySoarer.mods[1]=1 end)
    ModPageSS:newAction()
        :item("minecraft:light_blue_wool"):title("Medium Velocity")
        :onLeftClick(function() SkySoarer.mods[1]=2 end)
    ModPageSS:newAction()
        :item("minecraft:blue_wool"):title("High Velocity")
        :onLeftClick(function() SkySoarer.mods[1]=3 end)
    ModPageSS:newAction()
        :item("minecraft:melon_slice"):title("Regenerative Sky")
        :toggleColor(0,0,0)
        :onToggle(function(state) 
            if state then SkySoarer.mods[2]=1 
            else SkySoarer.mods[2]=0 end 
        end)


    Shatter = {
        name="Shatter", id="shatter",
        hue1="606060", hue2="c0c0c0",
        nick="§8S", poseAnim="",
        mods={} 
    }
    Radiance = {
        name="Radiance", id="radiance",
        hue1="ffff40", hue2="ffffc0",
        nick="§eR", poseAnim="",
        mods={} 
    }
    RoseThorns = {
        name="Rose Thorns", id="rosethorns",
        hue1="ff2040", hue2="20ff60",
        nick="§cR§aT", poseAnim="",
        mods={ 0 } --targets [living, hostile (peaceful), player]
    }
    ModPageRS = action_wheel:newPage()
    --Sky Soarer Modifiers--
    ModPageRS:newAction()
        :item("minecraft:egg"):title("Target: Living")
        :onLeftClick(function() RoseThorns.mods[1]=0 end)
    ModPageRS:newAction()
        :item("minecraft:creeper_spawn_egg"):title("Target: Hostiles")
        :onLeftClick(function() RoseThorns.mods[1]=1 end)
    ModPageRS:newAction()
        :item("minecraft:player_head"):title("Target: Players")
        :onLeftClick(function() RoseThorns.mods[1]=2 end)


    DandelionWinds = {
        name="Dandelion Winds", id="dandelionwinds",
        hue1="ffff20", hue2="ffb020",
        nick="§eD§fW", poseAnim="",
        mods={} 
    }
    ModPageDW = action_wheel:newPage()
    --Dandelion Winds Modifiers--

    Augment = {
        name="Augment", id="augment",
        hue1="45d17f", hue2="1c1c94",
        nick="§1A", poseAnim="",
        mods={
            0, --[slowfall, fire res, resistance, water breathing, strength, haste, regen, invis, speed]
            1 --buff potency 
        } 
    }
    local buffNames = {"Slowfalling", "Fire Resistance", "Resistance", "Water Breathing", "Strength", "Haste", "Regeneration", "Invisibility", "Speed"}
    ModPageA = action_wheel:newPage()
        --Augment Modifiers--
    ModPageA:newAction()
        :item("minecraft:brewing_stand"):title("Change Buff")
        :onLeftClick(function() 
            Augment.mods[1]=(Augment.mods[1]+1)%9  
            host:setActionbar("§aAugment Bestows§1: §0"..buffNames[(Augment.mods[1]%9)+1])
        end)
        :onRightClick(function() 
            Augment.mods[1]=(Augment.mods[1]-1)%9  
            host:setActionbar("§aAugment Bestows§1: §0"..buffNames[(Augment.mods[1]%9)+1])
        end)
    
end