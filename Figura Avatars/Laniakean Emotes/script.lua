-- Auto generated script file --
vanilla_model.PLAYER:setVisible(false)
--vanilla_model.LEFT_ELYTRA:setVisible(false)
--vanilla_model.RIGHT_ELYTRA:setVisible(false)

-- navigation functions --
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local hexPage = action_wheel:newPage()
local emotePage = action_wheel:newPage()
local bookPage = action_wheel:newPage()

mainPage:newAction()
    :title("Hex Commands"):item("hexcasting:spruce_staff")
    :hoverColor(vectors.hexToRGB("#462451"))
    :onLeftClick(function() action_wheel:setPage(hexPage) end)
mainPage:newAction()
    :title("Emotes"):item("minecraft:trident")
    :hoverColor(vectors.hexToRGB("#24514D"))
    :onLeftClick(function() action_wheel:setPage(emotePage) end)
mainPage:newAction()
    :title("Spellbook"):item("hexcasting:spellbook")
    :hoverColor(vectors.hexToRGB("#512424"))
    :onLeftClick(function() action_wheel:setPage(bookPage) end)

hexPage:newAction()
    :title("Return to Main"):item("hexcasting:spruce_staff")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)
emotePage:newAction()
    :title("Return to Main"):item("minecraft:trident")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)


-- HEX COMMANDS --
function pings.clearHex() animations.model.clearHex:play() end
hexPage:newAction()
    :title("Clear Command"):item("hexcasting:slate")
    :hoverColor(0.3, 0.3, 0.3):onLeftClick(pings.clearHex)

function pings.hexShot() animations.model.shoot:play() end
hexPage:newAction()
    :title("Hex Shot"):item("minecraft:arrow")
    :hoverColor(vectors.hexToRGB("#24514D")):onLeftClick(pings.hexShot)


-- EMOTES / VISUALS --
function pings.laniTestAnim() animations.model.twirl_trident:play() end
emotePage:newAction()
    :title("Emote: Twirl Trident"):item("minecraft:trident")
    :hoverColor(vectors.hexToRGB("#4DB17D")):onLeftClick(pings.laniTestAnim)

--local tex = textures:getTextures()
--for i,v in ipairs(tex) do print(v) end

-- SPELLBOOK PAGING --
local chapterPage1 = action_wheel:newPage()
local chapterPage2 = action_wheel:newPage()
local chapterPage3 = action_wheel:newPage()
local chapterPage4 = action_wheel:newPage()
local chapterPage5 = action_wheel:newPage()
local chapterPage6 = action_wheel:newPage()
local chapterPage7 = action_wheel:newPage()
local chapterPage8 = action_wheel:newPage()
local tableOfContents = {chapterPage1, chapterPage2, chapterPage3, chapterPage4, chapterPage5, chapterPage6, chapterPage7, chapterPage8}

for i,v in ipairs(tableOfContents) do
    bookPage:newAction()
        :item("hexcasting:focus"):title("Chapter " .. i)
        :onLeftClick(function() action_wheel:setPage(v) end)
        :hoverColor(vectors.hexToRGB("#54398a"))
    for j = 1, 8 do
        v:newAction()
            :setTexture(textures["icons.chapter" .. j]):title("Iota " .. j)
            :hoverColor(vectors.hexToRGB("#B38EF3"))
            :onLeftClick(function()
                if player:getHeldItem(true).id == "hexcasting:spellbook" then
                    host:sendChatMessage("!spellbooknav" .. ((i-1) * 8) + j - 1)
                    sounds:playSound("item.book.page_turn", player:getPos(), 0.7, 1.5, false)
                    pings.clearHex()
                    --host:setActionbar(player:getHeldItem(true):getName())
                else
                    host:setActionbar("No Spellbook!")
                end
            end)
        local j = j + 1
    end
end

-- KEYBINDS --
local hexShotKey = keybinds:newKeybind("Quick Hexshot", "key.keyboard.x")
hexShotKey.press = pings.hexShot


function events.tick()
    if action_wheel:getCurrentPage() ~= mainPage and not action_wheel:isEnabled()
        then action_wheel:setPage(mainPage) end
end

--[[
keybinds:fromVanilla("figura.config.action_wheel_button")
    :setOnRelease(function()
         if action_wheel:getCurrentPage() == bookPage
            then action_wheel:setPage(mainPage) end
     end)
]]--
