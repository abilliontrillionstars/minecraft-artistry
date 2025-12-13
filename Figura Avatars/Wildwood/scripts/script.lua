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

local testKey = keybinds:newKeybind("test", "key.keyboard.backslash", false)
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
SpellString = ""
function SendSpell(state, charge)
  SpellString = SIFTER
  if not state then state = LastMode end
  if not charge then charge = LastCharge end
  if state == "LEFT" then
    if STARRY_FORM then
      SpellString = SpellString.."punch:"  
    else
      SpellString = SpellString.."blast:"  
    end
  elseif state == "RIGHT" then
    SpellString = SpellString.."rblast:"
  elseif state == "DUAL" then
    SpellString = SpellString.."clap:"
  elseif state == "MIDDLE" then
  end
  SpellString = SpellString..charge..":"..world:getTime()
  --print(SpellString)
  host:sendChatMessage(SpellString)
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
  :title("Toggle Starry Form"):item("minecraft:nether_star")
  :onLeftClick(function() 
    if not STARRY_FORM then 
      pings.playAnim("starsIn") 
    else
      pings.playAnim("starsFadeOut") 
    end
  end)
MainPage:newAction()
    :title("Toggle Arcana"):item("minecraft:amethyst_shard")
    :onToggle(function() CAPTURE_MOUSE_BUTTONS = not CAPTURE_MOUSE_BUTTONS end)

MainPage:newAction(9)
    :title("Toggle Starry Rings"):item("minecraft:sunflower")
    :onLeftClick(function() pings.setDoRings(not DoRings) end)
MainPage:newAction(10)
    :title("Toggle Meditate"):item("minecraft:ender_eye")
    :onToggle(function(toggle) 
      if toggle then pings.playAnim("meditateNoSeatLoop")
      else
        pings.stopAnim("meditateNoSeatLoop")
        pings.playAnim("meditateNoSeatEnd")
      end
    end)



---------------------
--- API FUNCTIONS ---
---------------------
function events.tick()
  if action_wheel:getCurrentPage() ~= MainPage and not action_wheel:isEnabled()
      then action_wheel:setPage(MainPage) end
end

function events.on_play_sound(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those
    --print(id)    
    if path and player:isLoaded() then
      --replace casting noises with the staff percussion hit
      if (pos - player:getPos()):lengthSquared()<3 and (id:find("hermes") or id:find("thoth") or id == "hexcasting:casting.cast") then
        sounds:playSound("sounds.Staff percusses", player:getPos(), 1, 1+(math.random(-20,50)/100))
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
  if item:getID() == "hextended:staff/drawing_orb" then return models.aduene.ItemOrb end
  
  if item:getID() == "hexcasting:spellbook" or item:getID() == "hexgloop:covered_spellbook" then 
    if mode:find("FIRST") then 
      if mode:find("LEFT") then return models.aduene.ItemSpellbook:setRot(30,15,0)
      else return models.aduene.ItemSpellbook:setRot(30,-15,0) end 
    elseif mode:find("THIRD") then return models.aduene.ItemSpellbook:setRot(90,0,0) end
  end
end

ShiftPressed = false
CtrlPressed = false
function events.key_press(key, action)
  --track crouching locally by key
  if key==340 then
    if action==1 then ShiftPressed = true
    elseif action==0 then ShiftPressed = false end
  end
  --ditto for sprinting
  if key==341 then
    if action==1 then CtrlPressed = true
    elseif action==0 then CtrlPressed = false end
  end
end
