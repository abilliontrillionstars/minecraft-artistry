require("physBoneAPI")

vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
--vanilla_model.ALL:setVisible(false)
models.aduene.ItemStaff3D:setVisible(true)
models.aduene.ItemSpellbook:setVisible(true)
models.aduene.ItemRing:setVisible(true)


SIFTER = ","
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

local wristPocketKey = keybinds:newKeybind("Quick Wristpocket Spell", "key.keyboard.c", false)
  wristPocketKey.press = function() 
    if ShiftPressed then
        pings.playAnim("castFlickWrist")
    end
end
keybinds:fromVanilla("key.jump").press = function()
    if ShiftPressed then
        pings.playAnim("jumpSpin")
    end
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
    SpellString = ","..spell
  elseif type(spell) == "table" then
    SpellString = "," .. spell.id --",skysoarer"
    for i,v in pairs(spell.mods) do 
      SpellString = SpellString..'-'..v 
    end --",skysoarer-2-0"
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

function SetVanillaParent(toggle)
    if toggle then
        models.aduene.root.Head:setParentType("Head")
        models.aduene.root.Body:setParentType("Body")
        models.aduene.root.LeftArm:setParentType("LeftArm")
        models.aduene.root.RightArm:setParentType("RightArm")
        models.aduene.root.LeftLeg:setParentType("LeftLeg")
        models.aduene.root.RightLeg:setParentType("RightLeg")
    else
        models.aduene.root.Head:setParentType("None")
        models.aduene.root.Body:setParentType("None")
        models.aduene.root.LeftArm:setParentType("None")
        models.aduene.root.RightArm:setParentType("None")
        models.aduene.root.LeftLeg:setParentType("None")
        models.aduene.root.RightLeg:setParentType("None")
    end
end


---------------------
--- ACTION WHEEL  ---
---------------------
MainPage = action_wheel:newPage()
action_wheel:setPage(MainPage)

MainPage:newAction()
  :title("Toggle Starry Form")
  :onLeftClick(function() pings.StarryForm(not STARRY_FORM) end)


---------------------
--- API FUNCTIONS ---
---------------------
local watchForSpam = false
local cloakTimer = 0
function events.tick()
  if action_wheel:getCurrentPage() ~= MainPage and not action_wheel:isEnabled()
      then action_wheel:setPage(MainPage) end
   
  if host:isHost() then
        renderer:setRenderLeftArm(host:getSlot("weapon.offhand"):getID() == "minecraft:air")
        renderer:setRenderRightArm(host:getSlot("weapon.mainhand"):getID() == "minecraft:air")
  end

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

local rmbDown = false
local bookOpen = true
wheelClicks = 0
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

ShiftPressed = false
function events.key_press(key, action)
  --track crouching locally
  if key==340 then
    if action==1 then ShiftPressed = true
    elseif action==0 then ShiftPressed = false end
  end
end
