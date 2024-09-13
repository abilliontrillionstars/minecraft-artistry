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
models.aduene.ItemSpellbook:setVisible(true)
------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.playAnim(anim) animations.aduene[anim]:play() end
function pings.stopAnim(anim) animations.aduene[anim]:stop() end
function pings.sfx(sound, pitch) if player:isLoaded() then sounds:playSound(sound, player:getPos(), 1, pitch) end end
function pings.colorStaff(first, second)
  models.aduene.ItemStaff3D.leaf1:setColor(first)
  models.aduene.ItemStaff3D.leaf2:setColor(second)
end

----------------
--- KEYBINDS ---
----------------
if ENABLECANTRIPS then
  local sneakKey = keybinds:fromVanilla("key.sneak")
  local wristPocketKey = keybinds:newKeybind("Quick Wristpocket Spell", "key.keyboard.c", false)
  wristPocketKey.press = function() 
    if sneakKey:isPressed() then
      pings.playAnim("castFlickWrist")
      if player:isLoaded() then
        if player:getHeldItem(true).id:find("spellbook") then
          pings.playAnim("closeSpellbook") end 
      end
    end
  end
end

-----------------------
--- OTHER FUNCTIONS ---
-----------------------
SpellHistory = {"","","","",""}
SpellString = "!"
SpellNick = nil
function changeSpell(spell) 
    SendSpell(spell)
    --save to the history
    SpellHistory[1]=SpellHistory[2]
    SpellHistory[2]=SpellHistory[3]
    SpellHistory[3]=SpellHistory[4]
    SpellHistory[4]=SpellHistory[5]
    if SpellNick then SpellHistory[5]=SpellNick
    else SpellHistory[5]=SpellString end
    SpellNick=nil
    host:setActionbar(SpellHistory[1]..'§f-'..SpellHistory[2]..'§f-'..SpellHistory[3]..'§f-'..SpellHistory[4]..'§f-§n'..SpellHistory[5])
end

function SendSpell(spell)
--if passed a string, just use that
  if type(spell) == "string" then
    SpellString = "!"..spell
  elseif type(spell) == "table" then
    pings.colorStaff(vectors.hexToRGB(spell.hue1), vectors.hexToRGB(spell.hue2))
    SpellString = "!" .. spell.id --"!skysoarer"
    for i,v in pairs(spell.mods) do 
      SpellString = SpellString..'-'..v 
    end --"!skysoarer-2-0"
    SpellNick = spell.nick
  end
  host:sendChatMessage(SpellString)
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
    :onLeftClick(function() changeSpell(Shatter) end)
  spellPage:newAction()
    :item("minecraft:sunflower"):title("Radiance")
    :onLeftClick(function() changeSpell(Radiance) end)
  spellPage:newAction()
    :item("minecraft:rose_bush"):title("Rose Thorns")
    :onLeftClick(function() changeSpell(RoseThorns) end)
    :onRightClick(function() action_wheel:setPage(ModPageRS) end)
  spellPage:newAction()
    :item("minecraft:dandelion"):title("Dandelion Winds")
    :onLeftClick(function() changeSpell(DandelionWinds) end)
    :onRightClick(function() action_wheel:setPage(ModPageDW) end)
  spellPage:newAction()
    :item("minecraft:potion"):title("Augment")
    :onLeftClick(function() changeSpell(Augment) end)
    :onRightClick(function() action_wheel:setPage(ModPageA) end)
  

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
local watchForSpam = false
function events.tick()
  if action_wheel:getCurrentPage() ~= mainPage and not action_wheel:isEnabled()
      then action_wheel:setPage(mainPage) end
 
  renderer:setRenderLeftArm(player:getHeldItem(true).id == "minecraft:air")
  renderer:setRenderRightArm(player:getHeldItem().id == "minecraft:air" or player:getHeldItem().id == "hexgloop:casting_ring")
  
  watchForSpam = false
end
function events.on_play_sound(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those
    --print(id)
    
    if path and player:isLoaded() then
      --replace casting noises with the staff percussion hit
      if (pos - player:getPos()):lengthSquared()<3 and (id:find("hermes") or id:find("thoth") or id == "hexcasting:casting.cast") then
        sounds:playSound("Staff percusses", player:getPos(), 1, 1+(math.random(-20,50)/100))
        return true
      end
      --replace Hexical evoking noises with 
      if (pos - player:getPos()):lengthSquared()<1 and id == "hexical:evoking_murmur" then
        sounds:playSound("minecraft:block.beacon.power_select", player:getPos(), 1, 1+(math.random(-20,50)/100))
        return true
      end
    end

    --replace explosions with polite firework booms, or cancel duplicates of them
    if player:isLoaded() then
      if path and id:find("explode") and (pos - player:getPos()):lengthSquared() < 32^2 then
        if not watchForSpam then
          sounds["entity.firework_rocket.large_blast"]:pos(pos):play()
        end
        watchForSpam = true
        return true -- we return true here to cancel the sound
    end
  end
end
function events.item_render(item, mode)
  if item:getName():find("Druidic Staff") then return models.aduene.ItemStaff3D end
  if item:getID() == "hexgloop:casting_ring" then return models.aduene.ItemRing end

  if item:getID() == "hexcasting:spellbook" or item:getID() == "hexgloop:covered_spellbook" then 
    if mode:find("FIRST") then 
      if mode:find("LEFT") then return models.aduene.ItemSpellbook:setRot(30,15,0)
      else return models.aduene.ItemSpellbook:setRot(30,-15,0)
    end 
    elseif mode:find("THIRD") then return models.aduene.ItemSpellbook:setRot(90,0,0) end
  end
end
function events.entity_init()
  --physBone.physBoneMantle:setSpringForce(0.5)
end
function events.chat_receive_message(message, asJson) 
  --if message:find("[lua]") then return end
  --print(message) NO
end
local rmbDown = false
local bookOpen = true
function events.mouse_press(button, action)
  if player:isLoaded() then  
    if player:getHeldItem(true).id:find("spellbook") and player:getHeldItem(false).id == "minecraft:air" then
      if button==1 then
        if action==1 then rmbDown=true
        elseif action==0 then rmbDown=false
        end
      elseif button==0 and action==1 and rmbDown then
        if bookOpen then 
          pings.playAnim("closeSpellbook")
          pings.stopAnim("openSpellbook")
          bookOpen = false
        else 
          pings.playAnim("openSpellbook") 
          pings.stopAnim("closeSpellbook")
          bookOpen = true
        end
      end
    end
  end
end
