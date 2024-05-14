-- Auto generated script file --
vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
--vanilla_model.LEFT_ELYTRA:setVisible(false)
--vanilla_model.RIGHT_ELYTRA:setVisible(false)

-- navigation functions --
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local hexPage = action_wheel:newPage()
local emotePage = action_wheel:newPage()
local bookPage = action_wheel:newPage()

mainPage:newAction()
    :title("Hex Commands"):item("hexcasting:staff/spruce")
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

--[[
hexPage:newAction()
    :title("Return to Main"):item("hexcasting:staff/spruce")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)
emotePage:newAction()
    :title("Return to Main"):item("minecraft:trident")
    :onLeftClick(function() action_wheel:setPage(mainPage) end)
]]--

-- HEX COMMANDS --
function pings.clearHex() animations.model.spellClear:play() end
hexPage:newAction()
    :title("Clear Command"):item("hexcasting:slate")
    :hoverColor(0.3, 0.3, 0.3):onLeftClick(pings.clearHex)

function pings.hexShot() if player:isLoaded() then animations.model.spellHexshot:play() end end
hexPage:newAction()
    :title("Hex Shot"):item("minecraft:arrow")
    :hoverColor(vectors.hexToRGB("#24514D")):onLeftClick(pings.hexShot)

function mineHex()
    host:sendChatMessage("!hexmine")
    if player:isLoaded() then
        sounds:playSound("entity.evoker.cast_spell", player:getPos(), 0.7, 1.5, false)
    end
    pings.clearHex()
 end
hexPage:newAction()
    :title("Mine"):item("minecraft:iron_pickaxe")
    :hoverColor(vectors.hexToRGB("#24514D")):onLeftClick(mineHex)

function pings.castShockwave() if player:isLoaded() then animations.model.spellShockwave:play() end end
hexPage:newAction()
    :title("Shockwave"):item("minecraft:tnt")
    :hoverColor(vectors.hexToRGB("#462451")):onLeftClick(pings.castShockwave)

function itemAttract() host:sendChatMessage("!attractitems") end
hexPage:newAction()
    :title("Attract Items"):item("minecraft:hopper")
    :hoverColor(vectors.hexToRGB("#462451")):onLeftClick(itemAttract)
function pings.castForceCone() if player:isLoaded() then animations.model.spellForceCone:play() end end
hexPage:newAction()
    :title("Surge"):item("minecraft:piston")
    :hoverColor(vectors.hexToRGB("#462451")):onLeftClick(pings.castForceCone)
function pings.castIgnite() if player:isLoaded() then animations.model.spellIgnite:play() end end
hexPage:newAction()
    :title("Ignite"):item("minecraft:flint_and_steel")
    :hoverColor(vectors.hexToRGB("#462451")):onLeftClick(pings.castIgnite)




-- EMOTES / VISUALS --
function pings.laniTestAnim() animations.model.twirl_trident:play() end
emotePage:newAction()
    :title("Emote: Twirl Trident"):item("minecraft:trident")
    :hoverColor(vectors.hexToRGB("#4DB17D")):onLeftClick(pings.laniTestAnim)

local famParent = models.model.root.Head.FamiliarWisp
function pings.toggleFamiliar(vis) famParent:setVisible(vis) end
emotePage:newAction()
    :title("Toggle Familiar Wisp Bits"):item("minecraft:glowstone_dust")
    :hoverColor(vectors.hexToRGB("#462451")):onToggle(pings.toggleFamiliar)
    :setColor(vectors.hexToRGB("#200437")):setToggleColor(vectors.hexToRGB("#6f4fab"))

function pings.inquireAnim(vis) if player:isLoaded() then animations.model.inquire:play() end end
emotePage:newAction()
    :title("Emote: Huh?"):item("minecraft:lily_of_the_valley")
    :hoverColor(vectors.hexToRGB("#462451")):onLeftClick(pings.inquireAnim)




--local tex = textures:getTextures()
    --for i,v in ipairs(tex) do print(v) end

-- SPELLBOOK PAGING --
local tableOfContents = {action_wheel:newPage(), action_wheel:newPage(),
                        action_wheel:newPage(), action_wheel:newPage(),
                        action_wheel:newPage(), action_wheel:newPage(),
                        action_wheel:newPage(), action_wheel:newPage()}

for i,v in ipairs(tableOfContents) do
    bookPage:newAction()
        :setTexture(textures["icons.chapter" .. i]):title("Chapter " .. i)
        :onLeftClick(function() action_wheel:setPage(v) end)
        :hoverColor(vectors.hexToRGB("#54398a"))
    for j = 1, 8, 1 do
        v:newAction()
            :item("hexcasting:focus")
            :title("Iota " .. j)
            :hoverColor(vectors.hexToRGB("#B38EF3"))
            :onLeftClick(function()
                if player:getHeldItem(true).id == "hexcasting:spellbook" then
                    host:sendChatMessage("!spellbooknav" .. ((i-1) * 8) + j-1)
                    sounds:playSound("item.book.page_turn", player:getPos(), 0.7, 1.5, false)
                    --host:setActionbar(player:getHeldItem(true):getName())
                    pings.clearHex()
                else host:setActionbar("No Spellbook!") end
            end)
    end
end

--
function dymo_write(pageNum, item)
    local chapter = tableOfContents[math.floor(pageNum/8)+1]
    local action = chapter:getAction(pageNum%8)
    action:item(item)
    sounds:playSound("entity.villager.work_cartographer", player:getPos(), 1, 1, false)
end

-- KEYBINDS --
hexShotKey = keybinds:newKeybind("Quick Hexshot", "key.mouse.5")
hexShotKey.press = pings.hexShot

hexMineKey = keybinds:newKeybind("Quick Hexmine", "key.mouse.4")
hexMineKey.press = mineHex



-- OTHER FUNCTIONS --
function events.tick()
    if action_wheel:getCurrentPage() ~= mainPage and not action_wheel:isEnabled()
        then action_wheel:setPage(mainPage) end
    famParent.Halo:setRot(0,0,famParent.Halo:getRot()[3]-1)
end


--return true from this function to cancel the sound it's called on
function events.ON_PLAY_SOUND(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those

    --replace explosions with polite firework booms
    if path and id:find("explode") and (pos - player:getPos()):lengthSquared() < 32 then
        sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
        return true -- we return true here to cancel the sound
    end

    --silence my familiar wisp
    if path and id:find("wisp") and (pos - player:getPos()):lengthSquared() < 2 then
        return true -- we return true here to cancel the sound
    end
end


function events.CHAT_SEND_MESSAGE(message)
    if message == "?" then pings.inquireAnim() end
    return message
end


function events.item_render(item, context)
    if item.id == "hexcasting:staff/spruce" then
        if context == "FIRST_PERSON_RIGHT_HAND" or context == "FIRST_PERSON_LEFT_HAND" then
            return models.model.ItemStaffFP
        else
            return models.model.ItemStaff
        end
    end
end