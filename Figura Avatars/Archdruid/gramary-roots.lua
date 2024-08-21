if client.getVersion() == "1.19.2" then
    
    spellPage = action_wheel:newPage()

    SkySoarer = {
        name="Sky Soarer", id="skysoarer",
        hue1="20c8ff", hue2="2040ff",
        pose="",
        mods={
            2, --strength (magnitude multiplier)
            0 -- regenerative sky
        } 
    }

    for k,v in ipairs(SkySoarer) do
        print(v)    
    end

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
    --[[
    ModPageSS:newAction()
        :item("minecraft:string"):title("Burst <-> Channeled")
        :onToggle(function(state) print(state) end):toggleColor(0,0,0)
    ]]--
    ModPageSS:newAction()
        :item("minecraft:melon_slice"):title("Regenerative Sky")
        :toggleColor(0,0,0)
        :onToggle(function(state) 
            if state then SkySoarer.mods[2]=1 
            else SkySoarer.mods[2]=0 end 
        end)
        

end