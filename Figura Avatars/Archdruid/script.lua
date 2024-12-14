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
models.aduene.ItemRing:setVisible(true)

models.aduene.root.LeftArm.faunaWristLeft:setVisible(false)
models.aduene.root.RightArm.faunaWristRight:setVisible(false)


SpellHistory = {nil, nil, nil, nil, nil}
HistoryDepth = 0
SpellString = "!"
SpellCache = SkySoarer
------------------------
--- EMOTES / VISUALS ---
------------------------
function pings.playAnim(anim) 
  if animations.aduene[anim]:getLoop()=="LOOP" then
    animations.aduene[anim]:setPlaying(true)
  else
    animations.aduene[anim]:play()
  end
end
function pings.stopAnim(anim) 
  if animations.aduene[anim]:getLoop()=="LOOP" then
    animations.aduene[anim]:setPlaying(false)
  else
    animations.aduene[anim]:stop()
  end
end
function pings.sfx(sound, pitch) 
  if player:isLoaded() then 
    sounds:playSound(sound, player:getPos(), 1, pitch) end 
end
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
  local faunaKey = keybinds:newKeybind("Toggle Fauna-Eye", "key.mouse.middle", false)
  faunaKey.press = function()
    if sneakKey:isPressed() and player:isLoaded() then
      if player:getHeldItem(true):getID() == "minecraft:air" and player:getHeldItem(false):getID() == "minecraft:air" then
        ToggleFauna()
      end
    end
  end
end

local wheelClicks = 0
if ENABLEROOTS or ENABLEHEXES then
  --keybind to sense the closing of the action wheel
  local wheelRelease = keybinds:newKeybind("Figura Wheel Release", 
    keybinds:getVanillaKey("figura.config.action_wheel_button"))
  wheelRelease.release = function() 
    if wheelClicks>=3 then 
      SendSpell(SpellCache)
    end
    wheelClicks = 0
  end

  --next and previous buttons
  local prevSpell = keybinds:newKeybind("Previous Spell", "key.mouse.4")
  prevSpell.press = function()
    if HistoryDepth<4 then
      HistoryDepth=HistoryDepth+1 end
    RecallSpell(HistoryDepth)
  end
  local nextSpell = keybinds:newKeybind("Next Spell", "key.mouse.5")
  nextSpell.press = function()
    if HistoryDepth>0 then
      HistoryDepth=HistoryDepth-1 end
    RecallSpell(HistoryDepth)  end
  
end

-----------------------
--- OTHER FUNCTIONS ---
-----------------------
function ChangeSpell(spell) 
  SpellCache = spell
  SendSpell(spell)
  if type(spell) == "table" then
    pings.colorStaff(vectors.hexToRGB(spell.hue1), vectors.hexToRGB(spell.hue2)) end

  --save to the history
  SpellHistory[1]=SpellHistory[2]
  SpellHistory[2]=SpellHistory[3]
  SpellHistory[3]=SpellHistory[4]
  SpellHistory[4]=SpellHistory[5]
  SpellHistory[5]=spell

  local hudMessage=""
  for i,v in pairs(SpellHistory) do
    if v~=nil then 
      if type(v)=="table" then
        if i==5 then hudMessage=hudMessage.."{"..v.nick.."§f}"
        else hudMessage = hudMessage..v.nick end
      elseif type(v)=="string" then
        if i==5 then hudMessage=hudMessage.."{"..v.."§f}"
        else hudMessage = hudMessage..v end
      end
    end
    if i~=5 then hudMessage=hudMessage.."§f-" end
  end
  host:setActionbar(hudMessage)
end

function SendSpell(spell)
--if passed a string, just use that
  if type(spell) == "string" then
    SpellString = "!"..spell
  elseif type(spell) == "table" then
    SpellString = "!" .. spell.id --"!skysoarer"
    for i,v in pairs(spell.mods) do 
      SpellString = SpellString..'-'..v 
    end --"!skysoarer-2-0"
    SpellNick = spell.nick
  end
  host:sendChatMessage(SpellString)
end

function RecallSpell(depth)
  local spell = SpellHistory[5-depth]
  SpellCache = spell
  --send the chat signal for the spell
  if spell then
    SendSpell(spell) end
  --color the staff
  if type(spell)=="table" then
    pings.colorStaff(
    vectors.hexToRGB(SpellHistory[5-depth].hue1), vectors.hexToRGB(SpellHistory[5-depth].hue2)) end
  --and show the selection to the action bar
  local hudMessage = ""
  for i,v in pairs(SpellHistory) do
    if v~=nil then 
      if i==5-depth then hudMessage=hudMessage.."{"..v.nick.."§f}"
      else hudMessage = hudMessage..v.nick end
    end
    if i~=5 then hudMessage=hudMessage.."§f-" end
  end
  host:setActionbar(hudMessage)
end

function handleIdleMovement()
  models.aduene.root.Head.faunaEye.irisOuterLeft:setPos(math.sin(world.getTime()/10)/3,0,0)
  models.aduene.root.Head.faunaEye.irisOuterRight:setPos(math.sin(world.getTime()/10)/-3,0,0)
  models.aduene.root.RightArm.faunaWristRight:setScale(1+math.sin(world.getTime()/10)/10,1,1+math.sin(world.getTime()/10)/10)
  models.aduene.root.LeftArm.faunaWristLeft:setScale(1+math.sin(world.getTime()/10)/10,1,1+math.sin(world.getTime()/10)/10)
  models.aduene.root.Elytra.RightElytra.faunaWingRight:setPos(math.sin(world.getTime()/10)/4,math.sin(world.getTime()/10)/4,math.sin(world.getTime()/10)/4)
  models.aduene.root.Elytra.LeftElytra.faunaWingLeft:setPos(math.sin(world.getTime()/10)/-4,math.sin(world.getTime()/10)/4,math.sin(world.getTime()/10)/4)
end

FaunaActive = false
function ToggleFauna()
  if FaunaActive then
    pings.playAnim("deactivateFauna")
    FaunaActive = false
  else 
    pings.playAnim("activateFauna")
    FaunaActive = true
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
    :onLeftClick(function() ChangeSpell(SkySoarer) end)
    :onRightClick(function() action_wheel:setPage(ModPageSS) end)
  spellPage:newAction()
    :item("minecraft:golden_pickaxe"):title("Shatter")
    :onLeftClick(function() ChangeSpell(Shatter) end)
  spellPage:newAction()
    :item("minecraft:sunflower"):title("Radiance")
    :onLeftClick(function() ChangeSpell(Radiance) end)
  spellPage:newAction()
    :item("minecraft:rose_bush"):title("Rose Thorns")
    :onLeftClick(function() ChangeSpell(RoseThorns) end)
    :onRightClick(function() action_wheel:setPage(ModPageRS) end)
  spellPage:newAction()
    :item("minecraft:dandelion"):title("Dandelion Winds")
    :onLeftClick(function() ChangeSpell(DandelionWinds) end)
    :onRightClick(function() action_wheel:setPage(ModPageDW) end)
  spellPage:newAction()
    :item("minecraft:potion"):title("Augment")
    :onLeftClick(function() ChangeSpell(Augment) end)
    :onRightClick(function() action_wheel:setPage(ModPageA) end)
  spellPage:newAction()
    :item("minecraft:red_stained_glass"):title("Sanctuary")
    :onLeftClick(function() ChangeSpell(Sanctuary) end)
    --:onRightClick(function() action_wheel:setPage() end)
  

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
local cloakTimer = 0
function events.tick()
  handleIdleMovement()

  if action_wheel:getCurrentPage() ~= mainPage and not action_wheel:isEnabled()
      then action_wheel:setPage(mainPage) end
 
  renderer:setRenderLeftArm(player:getHeldItem(true).id == "minecraft:air")
  renderer:setRenderRightArm(player:getHeldItem().id == "minecraft:air" or player:getHeldItem().id == "hexgloop:casting_ring")
  
  if cloakTimer==0 then
    sounds:playSound("minecraft:block.beacon.activate", player:getPos(), 0.6, 2+(math.random(-20,50)/100))
  end
  cloakTimer = cloakTimer-1
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
      --replace Hexical evoking noises with beacon powah
      if (pos - player:getPos()):lengthSquared()<1 and id == "hexical:evoking_murmur" then
        sounds:playSound("minecraft:block.beacon.power_select", player:getPos(), 1, 1+(math.random(-20,50)/100))
        return true
      end

      --replace the botania cloak sound, and trigger a countdown
      if (pos - player:getPos()):lengthSquared()<1 and id == "botania:holy_cloak" then
        sounds:playSound("minecraft:block.beacon.deactivate", player:getPos(), 0.6, 2+(math.random(-20,50)/100))
        cloakTimer = 10*20 --ten seconds
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
      else return models.aduene.ItemSpellbook:setRot(30,-15,0) end 
    elseif mode:find("THIRD") then return models.aduene.ItemSpellbook:setRot(90,0,0) end
  end
end

function events.chat_receive_message(message, asJson) 
  --if message:find("[lua]") then return end
  --print(message)
  message= string.lower(message)
  if message:find("lani") and not message:find("<just_laniakea>") and player:isLoaded() then
    pings.sfx("entity.experience_orb.pickup",  0.5+math.random(0,4)/10)
    pings.sfx("entity.experience_orb.pickup",  0.2+math.random(0,4)/10)
  end
    
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
    if player:getHeldItem():getName() == "Druidic Staff" and not action_wheel:isEnabled() then
      if button==1 then
        if action==1 then
          if SpellCache and SpellCache.poseAnim ~= "" then pings.playAnim(SpellCache.poseAnim) end
        elseif action==0 then
          if SpellCache and SpellCache.poseAnim ~= "" then 
            if animations.aduene[SpellCache.poseAnim]:getLoop()=="LOOP" then 
              pings.stopAnim(SpellCache.poseAnim) end
          end
        end
      end
    end
    
  end

  if action_wheel:isEnabled() then
    if action==1 then wheelClicks=wheelClicks+1 end
  end
end
