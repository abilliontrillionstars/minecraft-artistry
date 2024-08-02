require("physBoneAPI")

local ENABLECANTRIPS = true
local ENABLEHEXES = true
local ENABLEROOTS = true

if client.getVersion() ~= "1.19.2" then
  print("Minecraft Version incompatible with Hexcasting, disabling magicks")
  ENABLECANTRIPS = false
  ENABLEHEXES = false
  ENABLEROOTS = false
end

vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
--vanilla_model.ALL:setVisible(false)
models.aduene.ItemStaff3D:setVisible(true)
------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.playAnim(anim) animations.aduene[anim]:play() end
function pings.stopAnim(anim) animations.aduene[anim]:stop() end
function pings.sfx(sound, pitch) if player:isLoaded() then sounds:playSound(sound, player:getPos(), 1, pitch) end end

----------------
--- KEYBINDS ---
----------------

-----------------------
--- OTHER FUNCTIONS ---
-----------------------
function pings.colorStaff(first, second)
  models.aduene.ItemStaff3D.leaf1:setColor(first)
  models.aduene.ItemStaff3D.leaf2:setColor(second)
end

SpellString = ""
function changeSpell(spell) 
    if type(spell) == "string" then
      SpellString = spell
    elseif type(spell) == "table" then
      print(spell)
      pings.colorStaff(vectors.hexToRGB(spell.hue1), vectors.hexToRGB(spell.hue2))
      SpellString = "!" .. spell.id .. spell.state
      host:sendChatMessage(SpellString)
    end
end
---------------------
--- ACTION WHEEL  ---
---------------------
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

if ENABLEROOTS then 
  require("gramary-roots") 
  mainPage:newAction()
    :title("Roots Spells")
    :item("minecraft:oak_sapling")
    :hoverColor(vectors.hexToRGB("#6c8031"))
    :onLeftClick(function() action_wheel:setPage(spellPage) end)

  spellPage:newAction()
    :item("minecraft:feather"):title("Sky Soarer")
    :onLeftClick(function() changeSpell(SkySoarer) end)
    :onRightClick(function() action_wheel:setPage(ModPageSS) end)

  spellPage:newAction()
    :item("minecraft:golden_pickaxe"):title("Shatter")
    :onLeftClick(function() 
    pings.colorStaff(vectors.hexToRGB("#606060"), vectors.hexToRGB("#c0c0c0"))
    host:sendChatMessage("!shatter")
    end)
  spellPage:newAction()
    :item("minecraft:sunflower"):title("Radiance")
    :onLeftClick(function() 
    pings.colorStaff(vectors.hexToRGB("#ffff40"), vectors.hexToRGB("#ffffc0"))
    host:sendChatMessage("!radiance")
    end)

--color each action
for i,v in pairs(spellPage:getActions()) do v:hoverColor(vectors.hexToRGB("#3a5b24")) end
end
if ENABLEHEXES then 
  require("gramary-hex")
  mainPage:newAction()
    :title("Other Hexes")
    :item("minecraft:amethyst_shard")
    :hoverColor(vectors.hexToRGB("#8d6acc"))
    :onLeftClick(function() action_wheel:setPage(hexPage) end)
end
if ENABLECANTRIPS then
  require("gramary-cantrips")
  mainPage:newAction()
    :title("Bound Cantrips"):item("minecraft:totem_of_undying")
    :hoverColor(vectors.hexToRGB("#5d4627"))
    :onLeftClick(function() action_wheel:setPage(cantripPage) end)
end

---------------------
--- API FUNCTIONS ---
---------------------
local watchForSpam = true
function events.tick()
  if action_wheel:getCurrentPage() ~= mainPage and not action_wheel:isEnabled()
      then action_wheel:setPage(mainPage) end
      
  renderer:setRenderLeftArm(player:getHeldItem(true).id == "minecraft:air")
  watchForSpam = false
end
function events.on_play_sound(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those
    
    --sounds played in the same tick will get muted
    if watchForSpam then return true end
    --replace casting noises with the staff percussion hit
    if path and player:isLoaded() then
      if (pos - player:getPos()):lengthSquared()<3 and (id:find("hermes") or id:find("thoth") or id == "hexcasting:casting.cast") then
        sounds:playSound("Staff percusses", player:getPos(), 1, 1+(math.random(-20,50)/100))
        return true
      end
    end

    --replace explosions with polite firework booms
    if player:isLoaded() then
      if path and id:find("explode") and (pos - player:getPos()):lengthSquared() < 32^2 then
        sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
        watchForSpam = true
        return true -- we return true here to cancel the sound
    end
  end
end
function events.item_render(item, mode)
  if item:getName():find("Druidic Staff") then return models.aduene.ItemStaff3D end
end
function events.entity_init()
  --physBone.physBoneMantle:setSpringForce(0.5)
end
function events.chat_receive_message(message, asJson) 
  --if message:find("[lua]") then return end
  --print(message)
end