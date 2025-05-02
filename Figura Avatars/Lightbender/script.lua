vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

mainPage:newAction()
    :title("Party Invite Vex"):item("minecraft:iron_sword")
    :hoverColor(vectors.hexToRGB("#462451"))
    :onLeftClick(function() host:sendChatMessage("/party invite Vexify27") end)
mainPage:newAction()
    :title("Housing Invite Vex"):item("minecraft:vex_spawn_egg")
    :hoverColor(vectors.hexToRGB("#462451"))
    :onLeftClick(function() host:sendChatMessage("/housing invite Vexify27") end)
mainPage:newAction()
    :title("Toggle Housing Edit"):item("minecraft:oak_log")
    :hoverColor(vectors.hexToRGB("#462451"))
    :onLeftClick(function() host:sendChatMessage("/housing edit") end)

    