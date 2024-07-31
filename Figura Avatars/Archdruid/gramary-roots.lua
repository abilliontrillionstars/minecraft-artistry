spellPage = action_wheel:newPage()

SkySoarer = {
    name="skysoarer",
    hue1="20c8ff",
    hue2="2040ff",
    state=1 --Medium Strength Burst (Propulsion)
}

ModPageSS = action_wheel:newPage()
--Sky Soarer Modifiers--
ModPageSS:newAction()
    :item("minecraft:white_wool"):title("Low Velocity")
    :onLeftClick(function() SkySoarer.state=0 end)
ModPageSS:newAction()
    :item("minecraft:light_blue_wool"):title("Medium Velocity")
    :onLeftClick(function() SkySoarer.state=1 end)
ModPageSS:newAction()
    :item("minecraft:blue_wool"):title("High Velocity")
    :onLeftClick(function() SkySoarer.state=2 end)
ModPageSS:newAction()
    :item("minecraft:string"):title("Burst <-> Channeled")
    :onToggle(function(state) print(state) end):toggleColor(0,0,0)
    

    