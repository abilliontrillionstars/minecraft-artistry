require("arcana.directory")
SIFTER = ","
ArcanaString = ""

local testPage = action_wheel:newPage()
MainPage:newAction()
    :title("Other"):item("spectrum:paintbrush")
    :onLeftClick(function() action_wheel:setPage(testPage) end)

testPage:newAction()
    :title("Test Apron Color"):item("botania:spectrolus")
    :onLeftClick(function() pings.ColorMain(vec(math.random(), math.random(), math.random())) end)
testPage:newAction()
    :title("Test Casting Anim"):item("minecraft:end_portal_frame")
    :onLeftClick(function() pings.playAnim("testStaffOrbit1") end)
testPage:newAction()
    :title("Test Brush-Staff"):item("hexcasting:staff/spruce")
    :onLeftClick(function() pings.ToggleBrushStaff() end)
testPage:newAction()
    :title("Test Staff Emotecast"):item("hexcasting:staff/cherry")
    :onLeftClick(function() pings.playAnim("castStaffOrbit1") end)


OrangePage:newAction()
    :title("Ignite Monsters"):item("minecraft:fire_charge")
    :onLeftClick(function() 
        pings.ColorFX("orange")
        ArcanaString = "area.fire.monster"
        pings.playAnim("castStaffOrbit1") 
    end)
PinkPage:newAction()
    :title("Heal Players"):item("minecraft:glistering_melon")
    :onLeftClick(function() 
        pings.ColorFX("pink")
        ArcanaString = "area.heal.player"
        pings.playAnim("castStaffOrbit1") 
    end)
