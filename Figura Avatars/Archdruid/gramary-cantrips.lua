if client.getVersion() == "1.19.2" then
  
  cantripPage = action_wheel:newPage()

  cantripPage:newAction()
  :title("Size Control"):item("minecraft:pufferfish")
  :onLeftClick(function() 
    changeSpell("resize0")
    pings.playAnim("castHandSwirl")
  end)
  cantripPage:newAction()
  :title("Return Home"):item("create:lime_seat")
  :onLeftClick(function() 
    changeSpell("homeward0")
    pings.playAnim("castHandSwirl")
  end)
  local buffNum = 0
  local buffNames = {"slowfall", "fire res", "resistance", "waterbreathing", "strength", "haste", "regen", "invis", "speed"}
  cantripPage:newAction()
  :title("Bestow Buffs"):item("minecraft:potion")
  :onLeftClick(function() 
    changeSpell("buff"..buffNum%9)
    pings.playAnim("castHandSwirl")
  end)
  :onRightClick(function()
    buffNum = buffNum+1
    host:setActionbar("Buff: "..buffNames[(buffNum%9)+1])
  end)
  local brewNum = 0
  local brewNames = {"emptiness", "bloodthirst", "featherfeet", "soulcross", "allure"}
  cantripPage:newAction()
  :title("Bestow Brews"):item("botania:brew_vial")
  :onLeftClick(function() 
    changeSpell("brew"..brewNum%5)
    pings.playAnim("castHandSwirl")
  end)
  :onRightClick(function()
    brewNum = brewNum+1
    host:setActionbar("Brew: "..brewNames[(brewNum%5)+1])
  end)

  --color each action
  for i,v in pairs(cantripPage:getActions()) do v:hoverColor(vectors.hexToRGB("#5d4627")) end

end