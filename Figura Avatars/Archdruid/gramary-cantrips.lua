if client.getVersion() == "1.19.2" then
  cantripPage = action_wheel:newPage()

  cantripPage:newAction()
    :title("Size Control"):item("minecraft:pufferfish")
    :onLeftClick(function() 
      SpellString = "resize0"
      pings.playAnim("castHandSwirl")
    end)


  cantripPage:newAction()
    :title("Return Home"):item("create:lime_seat")
    :onLeftClick(function() 
      SpellString = "homeward0"
      pings.playAnim("castHandSwirl")
    end)

  cantripPage:newAction()
    :title("Gate to Spawn"):item("botania:world_seed")
    :onLeftClick(function() 
      SpellString = "spawnward0"
      pings.playAnim("castHandSwirl")
    end)

  local brewNum = 0
  local brewNames = {"emptiness", "bloodthirst", "featherfeet", "soulcross", "allure"}
  cantripPage:newAction()
    :title("Bestow Brews"):item("botania:brew_vial")
    :onLeftClick(function() 
      SpellString = "brew"..brewNum%5
      pings.playAnim("castHandSwirl")
    end)
    :onRightClick(function()
      brewNum = brewNum+1
      host:setActionbar("Brew: "..brewNames[(brewNum%5)+1])
    end)

  cantripPage:newAction()
    :title("Bound Recharge"):item("minecraft:chorus_flower")
    :onLeftClick(function() pings.playAnim("castRaiseStaff") end)
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