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
        nick="§cR§aT", poseAnim="poseToss",
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
        nick="§eD§fW", poseAnim="posePush",
        mods={
            0, --[normal, updraft, downburst] pick wind hex
            2, --strength of the impulse
            0.75, --dot product threshold for targeting/particles (-1 for target all, closer to 1 means narrower)
            0 --targets [living, hostile (peaceful), player, items]
        } 
    }
    ModPageDW = action_wheel:newPage()
    --Dandelion Winds Modifiers--
    local windDirs = {"Winds", "Updraft", "Downburst"}
    local windDirPoses =  {"posePush", "poseRaiseStaff", "posePush"}
    ModPageDW:newAction()
        :item("minecraft:fern"):title("Winds/Updraft/Downburst")
        :onLeftClick(function() 
            DandelionWinds.mods[1]=math.min(DandelionWinds.mods[1]+1, 2) 
            host:setActionbar("Type: "..windDirs[DandelionWinds.mods[1]+1])
            DandelionWinds.poseAnim = windDirPoses[DandelionWinds.mods[1]+1]
        end)
        :onRightClick(function()  
            DandelionWinds.mods[1]=math.max(DandelionWinds.mods[1]-1, 0) 
            host:setActionbar("Type: "..windDirs[DandelionWinds.mods[1]+1])   
            DandelionWinds.poseAnim = windDirPoses[DandelionWinds.mods[1]+1]
        end)
        local windTargets = {"Living", "Hostile", "Players", "Items"}
    ModPageDW:newAction()
        :item("minecraft:egg"):title("Targets")
        :onLeftClick(function() 
            DandelionWinds.mods[4]=math.min(DandelionWinds.mods[4]+1, 3) 
            host:setActionbar("Target: "..windTargets[DandelionWinds.mods[4]+1])
        end)
        :onRightClick(function()  
            DandelionWinds.mods[4]=math.max(DandelionWinds.mods[4]-1, 0) 
            host:setActionbar("Target: "..windTargets[DandelionWinds.mods[4]+1])   
        end)
    

    Augment = {
        name="Augment", id="augment",
        hue1="45d17f", hue2="1c1c94",
        nick="§1A", poseAnim="poseRaiseStaff",
        mods={
            0, --[slowfall, fire res, resistance, water breathing, strength, haste, regen, invis, speed]
            1, --buff potency 
            2 --armor strength
        } 
    }
    local buffNames = {"Slowfalling", "Fire Resistance", "Resistance", "Water Breathing", "Strength", "Haste", "Regeneration", "Invisibility", "Speed"}
    ModPageA = action_wheel:newPage()
        --Augment Modifiers--
    ModPageA:newAction()
        :item("minecraft:brewing_stand"):title("Change Buff")
        :onLeftClick(function() 
            Augment.mods[1]=(Augment.mods[1]+1)%9  
            host:setActionbar("§1Augment Bestows: §b"..buffNames[(Augment.mods[1]%9)+1])
        end)
        :onRightClick(function() 
            Augment.mods[1]=(Augment.mods[1]-1)%9  
            host:setActionbar("§1Augment Bestows: §b"..buffNames[(Augment.mods[1]%9)+1])
        end)
    ModPageA:newAction()
        :item("minecraft:chainmail_chestplate"):title("Armor Value")
        :onLeftClick(function() 
            Augment.mods[3]=math.min(Augment.mods[3]+1, 10)  
            host:setActionbar("§1Armor Potency: §b"..Augment.mods[3])
        end)
        :onRightClick(function() 
            Augment.mods[3]=math.max(Augment.mods[3]-1, 0)  
            host:setActionbar("§1Armor Potency: §b"..Augment.mods[3])
        end)
    
        Sanctuary = {
            name="Sanctuary", id="sanctuary",
            hue1="d01050", hue2="e02090",
            nick="§cS", poseAnim="poseStaffLongpointGuard",
            mods={} 
        }
end