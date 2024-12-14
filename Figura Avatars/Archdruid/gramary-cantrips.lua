if client.getVersion() == "1.19.2" then
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

  cantripPage:newAction(9)
    :title("Call Perrin & Paddan"):item("minecraft:bone")
    :onLeftClick(function() 
      CantripString = "wolf0"
      pings.playAnim("castDualOverheadHand")   
    end)

  cantripPage:newAction()
    :title("Test Clap Anim"):item("minecraft:bamboo")
    :onLeftClick(function() 
      CantripString = "test0"
      pings.playAnim("castClap")   
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
end