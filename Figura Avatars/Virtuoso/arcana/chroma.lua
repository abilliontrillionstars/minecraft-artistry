require("arcana.directory")
SIFTER = ","
ArcanaString = ""
ArcanaAnim = ""

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

OrangePage:newAction()
    :title("Combust Monsters"):item("minecraft:fire_charge")
    :onLeftClick(function() SendArcana("area:monster:combust", "castArmsOut1", "orange") end)
OrangePage:newAction()
    :title("Ignite Monsters"):item("minecraft:flint_and_steel")
    :onLeftClick(function() SendArcana("area:monster:ignite", "castInkCross1", "orange") end)

PinkPage:newAction()
    :title("Heal Players"):item("minecraft:glistering_melon_slice")
    :onLeftClick(function() SendArcana("area:player:heal", "castStaffOrbit1", "pink") end)

YellowPage:newAction()
    :title("Brush Shift: Radiance Staff"):item("spectrum:radiance_staff")
    :onLeftClick(function() SendArcana("brush-shift:radiance staff", "castSpinRaiseWand", "yellow") end)

LimePage:newAction()
    :title("Brush Shift: Nature's Staff"):item("spectrum:natures_staff")
    :onLeftClick(function() SendArcana("brush-shift:nature's staff", "castSpinRaiseWand", "lime") end)

GrayPage:newAction()
    :title("Item Cleanup"):item("hexal:mediafied_storage")
    :onLeftClick(function() SendArcana("area:item:mediafy:foo", "castSpinRaiseWand", "gray") end)

CyanPage:newAction()
    :title("Brush Shift: Multitool"):item("spectrum:multitool")
    :onLeftClick(function() SendArcana("brush-shift:multitool", "castSpinRaiseWand", "cyan") end)

GreenPage:newAction()
    :title("Warp Home"):item("minecraft:dark_oak_sapling")
    :onLeftClick(function() SendArcana("area:player:gate:home", "castSpinRaiseWand", "green") end)

PurplePage:newAction()
    :title("Warp to Wheel HQ"):item("supplementaries:statue")
    :onLeftClick(function() SendArcana("area:player:gate:wheel", "castSpinRaiseWand", 'purple') end)



testPage:newAction()
    :title("Drawing <-> Painting"):item("spectrum:paintbrush")
    :onLeftClick(function() 
        if player:isLoaded() then
            if player:getHeldItem():getID() == "spectrum:paintbrush" then
                SendArcana("brush-shift:birch staff", "castSpinRaiseWand", "white")
            else
                SendArcana("brush-shift:paintbrush", "castSpinRaiseWand", "white")
            end
        end
    end)
