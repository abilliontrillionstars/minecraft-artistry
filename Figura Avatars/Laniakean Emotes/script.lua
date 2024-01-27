-- Auto generated script file --
vanilla_model.PLAYER:setVisible(false)

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

function pings.laniTestAction()
    host:sendChatMessage("wah")
end

local action = mainPage:newAction()
    :title("Lani Test Action")
    :item("minecraft:stick")
    :hoverColor(0.274, 0.317, 0.086)
    :onLeftClick(pings.laniTestAction)

function pings.laniTestAnim()
    animations.model.twirl_trident:play()
end

local action = mainPage:newAction()
    :title("Emote: Twirl Trident")
    :item("minecraft:trident")
    :hoverColor(0.274, 0.317, 0.086)
    :onLeftClick(pings.laniTestAnim)