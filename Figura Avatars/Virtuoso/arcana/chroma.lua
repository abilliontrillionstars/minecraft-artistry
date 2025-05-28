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


--------------------------
--------- MATTER ---------
--------------------------
CyanPage:newAction()
    :title("Brush Shift: Multitool"):item("spectrum:multitool")
    :onLeftClick(function() SendArcana("brush-shift:multitool", "castArmsIn1", "cyan") end)
CyanPage:newAction()
    :title("Brush Shift: Construction Staff"):item("spectrum:constructors_staff")
    :onLeftClick(function() SendArcana("brush-shift:constructor's staff", "castArmsIn1", "cyan") end)
CyanPage:newAction()
    :title("Charge Artifacts"):item("hexcasting:trinket")
    :onLeftClick(function() SendArcana("area:item:recharge:foo", "castArmsOut1", "cyan") end)

LightBluePage:newAction()
    :title("Glow Vision"):item("minecraft:glow_ink_sac")
    :onLeftClick(function() SendArcana("area:player:night-vision", "castInkCross1", "light_blue") end)
LightBluePage:newAction()
    :title("Winter Wind"):item("minecraft:snow")
    :onLeftClick(function() SendArcana("cont:winter-wind:2", "castTwirlStaff1Start", "light_blue") end)
LightBluePage:newAction()
    :title("Brush Shift: Crescent Clock"):item("spectrum:crescent_clock")
    :onLeftClick(function() SendArcana("brush-shift:crescent clock", "castArmsIn1", "light_blue") end)

BluePage:newAction()
    :title("Don Magic Plate"):item("ephemera:media_chestplate")
    :onLeftClick(function() SendArcana("self-aegis", "castInkCross1", "blue") end)
BluePage:newAction()
    :title("Anti-Projectile Zone"):item("minecraft:tube_coral_fan")
    :onLeftClick(function() SendArcana("reflector-wisp", "castArmsOut1", "blue") end)
BluePage:newAction()
    :title("Conjured Cover"):item("minecraft:shield")
    :onLeftClick(function() SendArcana("cont:forcefield", "castTwirlStaff1Start", "blue") end)

LimePage:newAction()
    :title("Brush Shift: Nature's Staff"):item("spectrum:natures_staff")
    :onLeftClick(function() SendArcana("brush-shift:nature's staff", "castArmsIn1", "lime") end)

--------------------------
---------- TIME ----------
--------------------------
MagentaPage:newAction()
    :title("Slow Time"):item("minecraft:cobweb")
    :onLeftClick(function() SendArcana("area:living:slow-time", "castStaffOrbit1", "magenta") end)
MagentaPage:newAction()
    :title("Speed Time"):item("minecraft:clock")
    :onLeftClick(function() SendArcana("cont:accelerate", "castTwirlStaff1Start", "magenta") end)
MagentaPage:newAction()
    :title("Brush Shift: Bag of Holding"):item("spectrum:bag_of_holding")
    :onLeftClick(function() SendArcana("brush-shift:bag of holding", "castArmsIn1", "magenta") end)


PinkPage:newAction()
    :title("Heal Players"):item("minecraft:glistering_melon_slice")
    :onLeftClick(function() SendArcana("area:player:heal", "castArmsOut2", "pink") end)
PinkPage:newAction()
    :title("Heal Living"):item("spectrum:glistering_melon")
    :onLeftClick(function() SendArcana("area:living:heal", "castArmsOut2", "pink") end)

PurplePage:newAction()
    :title("Warp to the Academy"):item("minecraft:lectern")
    :onLeftClick(function() SendArcana("area:player:gate:acad", "castInkCircle1", "purple") end)
PurplePage:newAction()
    :title("Call Guidebook"):item("spectrum:guidebook")
    :onLeftClick(function() SendArcana("brush-shift:colorful world", "castArmsIn1", "purple") end)

RedPage:newAction()
    :title("Toss Monsters"):item("minecraft:creeper_head")
    :onLeftClick(function() SendArcana("area:monster:toss:foo", "castSlamStaff1", "red") end)
RedPage:newAction()
    :title("Warp to the Pale Garden"):item("minecraft:wither_rose")
    :onLeftClick(function() SendArcana("area:player:gate:greenland", "castInkCircle1", "red") end)
RedPage:newAction()
    :title("Summon Estrogen"):item("estrogen:estrogen_pill")
    :onLeftClick(function() SendArcana("brush-shift:estrogen pill", "castArmsIn1", "red") end)

--------------------------
--------- ENERGY ---------
--------------------------
YellowPage:newAction()
    :title("Brush Shift: Radiance Staff"):item("spectrum:radiance_staff")
    :onLeftClick(function() SendArcana("brush-shift:radiance staff", "castArmsIn1", "yellow") end)
YellowPage:newAction()
    :title("Bestow Elytra"):item("minecraft:elytra")
    :onLeftClick(function() SendArcana("area:player:altiora", "castSpinRaiseWand", "yellow") end)
YellowPage:newAction()
    :title("Bestow Flight"):item("minecraft:feather")
    :onLeftClick(function() SendArcana("area:player:anchorite", "castInkCircle1", "yellow") end)
YellowPage:newAction()
    :title("Zap"):item("spectrum:citrine_sugar_stick")
    :onLeftClick(function() SendArcana("zap", "castSlingInk1", "yellow") end)


BrownPage:newAction()
    :title("Conjure Water"):item("minecraft:water_bucket")
    :onLeftClick(function() SendArcana("conjure-water", "castInkCircle1", "brown") end)
BrownPage:newAction()
    :title("Pick Fruit"):item("oneironaut:monkfruit")
    :onLeftClick(function() SendArcana("brush-shift:monkfruit,32", "castArmsIn1", "brown") end)


GreenPage:newAction()
    :title("Warp Home"):item("minecraft:dark_oak_sapling")
    :onLeftClick(function() SendArcana("area:player:gate:home", "castInkCircle1", "green") end)
GreenPage:newAction()
    :title("Mass Cure"):item("minecraft:milk_bucket")
    :onLeftClick(function() SendArcana("area:living:cure", "castInkCross1", "green") end)
GreenPage:newAction()
    :title("Brush Shift: Crafting Tablet"):item("spectrum:crafting_tablet")
    :onLeftClick(function() SendArcana("brush-shift:crafting tablet", "castArmsIn1", "green") end)

OrangePage:newAction()
    :title("Combust Monsters"):item("minecraft:fire_charge")
    :onLeftClick(function() SendArcana("area:monster:combust", "castArmsOut1", "orange") end)
OrangePage:newAction()
    :title("Ignite Monsters"):item("minecraft:flint_and_steel")
    :onLeftClick(function() SendArcana("area:monster:ignite", "castInkCross1", "orange") end)
OrangePage:newAction()
    :title("Bulk Smelt"):item("minecraft:furnace")
    :onLeftClick(function() SendArcana("area:item:smelt:foo", "castInkCircle1", "orange") end)


BlackPage:newAction()
    :title("Warp to Wheel HQ"):item("supplementaries:statue")
    :onLeftClick(function() SendArcana("area:player:gate:wheel", "castInkCircle1", "black") end)

GrayPage:newAction()
    :title("Item Cleanup"):item("hexal:mediafied_storage")
    :onLeftClick(function() SendArcana("area:item:mediafy:foo", "castSpinRaiseWand", "gray") end)

LightGrayPage:newAction()
    :title("Wall Phase"):item("minecraft:scaffolding")
    :onLeftClick(function() SendArcana("wall-phase", "castInkCross1", "light_gray") end)








testPage:newAction()
    :title("Drawing <-> Painting"):item("spectrum:paintbrush")
    :onLeftClick(function() 
        if player:isLoaded() then
            if player:getHeldItem():getID() == "spectrum:paintbrush" then
                host:sendChatMessage(SIFTER.."brush-shift:birch staff".. ":" .. world.getTime())
                if BRUSHMODE == "STAFF" then pings.playAnim("brushToWand") end
            else
                host:sendChatMessage(SIFTER.."brush-shift:paintbrush".. ":" .. world.getTime())
            end
        end
    end)
