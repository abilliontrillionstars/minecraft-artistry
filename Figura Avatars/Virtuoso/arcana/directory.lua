
-----------
--TODO: make an arcana.lua (name wip) for actual arcana actions. this file is *just* for nav
-----------

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local testPage = action_wheel:newPage()
mainPage:newAction()
    :title("Testing"):item("minecraft:paper")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)
local CMYKPage = action_wheel:newPage()
mainPage:newAction()
    :title("Ink Arcana"):item("spectrum:pigment_palette")
    :onLeftClick(function() action_wheel:setPage(CMYKPage) end)

TopazPage = action_wheel:newPage()
AmethystPage = action_wheel:newPage()
CitrinePage = action_wheel:newPage()
CMYKPage:newAction()
    :title("MATTER"):item("spectrum:topaz_shard")
    :onLeftClick(function() action_wheel:setPage(TopazPage) end)
CMYKPage:newAction()
    :title("ENERGY"):item("spectrum:citrine_shard")
    :onLeftClick(function() action_wheel:setPage(CitrinePage) end)
CMYKPage:newAction()
    :title("TIME"):item("minecraft:amethyst_shard")
    :onLeftClick(function() action_wheel:setPage(AmethystPage) end)


CyanPage = action_wheel:newPage()
LightBluePage = action_wheel:newPage()
BluePage = action_wheel:newPage()
LimePage = action_wheel:newPage()
CyanPage:newAction()
    :title("Cyan"):item("minecraft:cyan_dye")
    :onLeftClick(function() action_wheel:setPage(CyanPage) end)
LightBluePage:newAction()
    :title("Light Blue"):item("minecraft:light_blue_dye")
    :onLeftClick(function() action_wheel:setPage(LightBluePage) end)
BluePage:newAction()
    :title("Blue"):item("minecraft:blue_dye")
    :onLeftClick(function() action_wheel:setPage(BluePage) end)
LimePage:newAction()
    :title("Lime"):item("minecraft:lime_dye")
    :onLeftClick(function() action_wheel:setPage(LimePage) end)


MagentaPage = action_wheel:newPage()
PinkPage = action_wheel:newPage()
PurplePage = action_wheel:newPage()
RedPage = action_wheel:newPage()
MagentaPage:newAction()
    :title("Magenta"):item("minecraft:magenta_dye")
    :onLeftClick(function() action_wheel:setPage(MagentaPage) end)
PinkPage:newAction()
    :title("Pink"):item("minecraft:pink_dye")
    :onLeftClick(function() action_wheel:setPage(PinkPage) end)
PurplePage:newAction()
    :title("Purple"):item("minecraft:purple_dye")
    :onLeftClick(function() action_wheel:setPage(PurplePage) end)
RedPage:newAction()
    :title("Red"):item("minecraft:red_dye")
    :onLeftClick(function() action_wheel:setPage(RedPage) end)


YellowPage = action_wheel:newPage()
BrownPage = action_wheel:newPage()
GreenPage = action_wheel:newPage()
OrangePage = action_wheel:newPage()
YellowPage:newAction()
    :title("Yellow"):item("minecraft:yellow_dye")
    :onLeftClick(function() action_wheel:setPage(YellowPage) end)
BrownPage:newAction()
    :title("Brown"):item("minecraft:brown_dye")
    :onLeftClick(function() action_wheel:setPage(BrownPage) end)
GreenPage:newAction()
    :title("Green"):item("minecraft:green_dye")
    :onLeftClick(function() action_wheel:setPage(GreenPage) end)
OrangePage:newAction()
    :title("Orange"):item("minecraft:orange_dye")
    :onLeftClick(function() action_wheel:setPage(OrangePage) end)






testPage:newAction()
    :title("Test Apron Color"):item("botania:spectrolus")
    :onLeftClick(function() pings.ColorMain(vec(math.random(), math.random(), math.random())) end)
testPage:newAction()
    :title("Test Casting Anim"):item("minecraft:end_portal_frame")
    :onLeftClick(function() pings.playAnim("testStaffOrbit1") end)
testPage:newAction()
    :title("Test Brush-Staff"):item("hexcasting:staff/spruce")
    :onLeftClick(function() pings.ToggleBrushStaff() end)
