-- Auto generated script file --
vanilla_model.PLAYER:setVisible(false)
vanilla_model.LEFT_ELYTRA:setVisible(false)
vanilla_model.RIGHT_ELYTRA:setVisible(false)


local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
local hexPage = action_wheel:newPage()
local emotePage = action_wheel:newPage()

-- navigation functions --
local action = mainPage:newAction()
    :title("Hex Commands"):item("hexcasting:spruce_staff")
    :hoverColor(0.164, 0.023, 0.247)
    :onLeftClick(function() action_wheel:setPage(hexPage) end)
local action = hexPage:newAction()
    :title("Return to Main"):item("hexcasting:spruce_staff")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)

local action = mainPage:newAction()
    :title("Emotes"):item("minecraft:trident")
    :hoverColor(0.188, 0.309, 0.25)
    :onLeftClick(function() action_wheel:setPage(emotePage) end)
local action = emotePage:newAction()
    :title("Return to Main"):item("minecraft:trident")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)

-- HEX COMMANDS --
function pings.clearHex()
    host:sendChatMessage("!")
    action_wheel:setPage(mainPage)
end
local action = hexPage:newAction()
    :title("Clear Command"):item("hexcasting:slate")
    :hoverColor(0.3, 0.3, 0.3):onLeftClick(pings.clearHex)





-- EMOTES / VISUALS --
function pings.laniTestAnim()
    animations.model.twirl_trident:play()
    action_wheel:setPage(mainPage)
end
local action = emotePage:newAction()
    :title("Emote: Twirl Trident")
    :item("minecraft:trident")
    :hoverColor(0.274, 0.317, 0.086)
    :onLeftClick(pings.laniTestAnim)