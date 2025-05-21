cantripPage = action_wheel:newPage()
CantripString = ""

cantripPage:newAction()
  :title("Size Control"):item("minecraft:pufferfish")
  :onLeftClick(function() 
    CantripString = "resize0"
    pings.playAnim("castHandSwirl")
  end)


cantripPage:newAction()
  :title("Return Home"):item("create:lime_seat")
  :onLeftClick(function() 
    CantripString = "homeward0"
    pings.playAnim("castHandSwirl")
  end)

cantripPage:newAction()
  :title("Gate to Spawn"):item("botania:world_seed")
  :onLeftClick(function() 
    CantripString = "spawnward0"
    pings.playAnim("castHandSwirl")
  end)

--cantripPage:newAction()
  --:title("Bound Recharge"):item("minecraft:chorus_flower")
  --:onLeftClick(function() pings.playAnim("castRaiseStaff") end)
rechargeKey = keybinds:newKeybind("Quickcast: Bound Recharge", "key.mouse.middle")
rechargeKey:onPress(function() 
  if player:isLoaded() then
    if player:getHeldItem():getName() == "Druidic Staff" then
      pings.playAnim("castRaiseStaff") end
  end
end)

cantripPage:newAction()
  :title("Circle Shot I"):item("minecraft:spectral_arrow")
  :onLeftClick(function() 
    CantripString = "hexshot0"
    pings.playAnim("castDualOverheadHand")   
  end)

  cantripPage:newAction()
  :title("Nature's Guillotine"):item("minecraft:pointed_dripstone")
  :onLeftClick(function() 
    CantripString = "drip0"
    pings.playAnim("castClap")   
  end)

cantripPage:newAction(9)
  :title("Call Lightning Chain"):item("minecraft:lightning_rod")
  :onLeftClick(function() 
    CantripString = "lightningchain0"
    pings.playAnim("castClapCharge")   
  end)

cantripPage:newAction(10)
  :title("Hextended Blink"):item("minecraft:ender_eye")
  :onLeftClick(function() 
    CantripString = "extblink0"
    pings.playAnim("castHandSwirl")   
  end) 

cantripPage:newAction(11)
  :title("Fern Wall"):item("minecraft:fern")
  :onLeftClick(function() 
    CantripString = "fernwall0"
    pings.playAnim("castClap")   
  end) 


cantripPage:newAction(17)
  :title("Summon Warden"):item("minecraft:sculk_catalyst")
  :onLeftClick(function() 
    CantripString = "warden0"
    pings.playAnim("castClapCharge")   
  end) 

--[[
cantripPage:newAction()
  :title("Reflect & Cast"):item("hexcasting:artifact")
  :onLeftClick(function() pings.playAnim("castFromSpellbook") end)
cantripPage:newAction()
  :title("Wristpocket"):item("minecraft:barrel")
  :onLeftClick(function() pings.playAnim("castFlickWrist") end)
]]-- 
--color each action
for i,v in pairs(cantripPage:getActions()) do v:hoverColor(vectors.hexToRGB("#5d4627")) end