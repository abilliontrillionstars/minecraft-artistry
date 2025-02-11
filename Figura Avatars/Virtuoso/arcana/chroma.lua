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

OrangePage:newAction()
    :title("Combust Monsters"):item("minecraft:fire_charge")
    :onLeftClick(function() 
        pings.ColorFX("orange")
        ArcanaString = "area:monster:combust"
        pings.playAnim("castStaffOrbit1") 
    end)
OrangePage:newAction()
    :title("Ignite Monsters"):item("minecraft:flint_and_steel")
    :onLeftClick(function() 
        pings.ColorFX("orange")
        ArcanaString = "area:monster:ignite"
        pings.playAnim("castInkCross1") 
    end)

PinkPage:newAction()
    :title("Heal Players"):item("minecraft:glistering_melon_slice")
    :onLeftClick(function() 
        pings.ColorFX("pink")
        ArcanaString = "area:player:heal"
        pings.playAnim("castStaffOrbit1") 
    end)

YellowPage:newAction()
    :title("Brush Shift: Radiance Staff"):item("spectrum:radiance_staff")
    :onLeftClick(function() 
        pings.ColorFX("yellow")
        ArcanaString = "brush-shift:radiance staff"
        pings.playAnim("castSpinRaiseWand") 
    end)
LimePage:newAction()
    :title("Brush Shift: Nature's Staff"):item("spectrum:natures_staff")
    :onLeftClick(function() 
        pings.ColorFX("lime")
        ArcanaString = "brush-shift:nature's staff"
        pings.playAnim("castSpinRaiseWand") 
    end)
GrayPage:newAction()
    :title("Item Cleanup"):item("hexal:mediafied_storage")
    :onLeftClick(function() 
        pings.ColorFX("gray")
        ArcanaString = "area:item:mediafy:foo"
        pings.playAnim("castSpinRaiseWand") 
    end)


CyanPage:newAction()
    :title("Brush Shift: Multitool"):item("spectrum:multitool")
    :onLeftClick(function() 
        pings.ColorFX("cyan")
        ArcanaString = "brush-shift:multitool"
        pings.playAnim("castSpinRaiseWand") 
    end)

GreenPage:newAction()
    :title("Warp Home"):item("minecraft:dark_oak_sapling")
    :onLeftClick(function() 
        pings.ColorFX("green")
        ArcanaString = "area:player:gate:home"
        pings.playAnim("castSpinRaiseWand") 
    end)
PurplePage:newAction()
    :title("Warp to Wheel HQ"):item("supplementaries:statue")
    :onLeftClick(function() 
        pings.ColorFX("purple")
        ArcanaString = "area:player:gate:wheel"
        pings.playAnim("castSpinRaiseWand") 
    end)

testPage:newAction()
    :title("Drawing <-> Painting"):item("spectrum:paintbrush")
    :onLeftClick(function() 
        pings.ColorFX("white")
        if player:isLoaded() then
            if player:getHeldItem():getID() == "spectrum:paintbrush" then
                ArcanaString = "brush-shift:birch staff" 
            else
                ArcanaString = "brush-shift:paintbrush"
            end
        end
        pings.playAnim("castSpinRaiseWand") 
    end)
