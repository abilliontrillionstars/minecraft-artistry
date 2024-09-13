if client.getVersion() == "1.19.2" then

  hexPage = action_wheel:newPage()

  hexPage:newAction()
    :item("hexcasting:trinket")
    :title("Read & Cast (Continuous)")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#820082"), vectors.hexToRGB("#cfa0f3"))
      changeSpell("cadcont")
    end)
  hexPage:newAction()
    :item("hexcasting:cypher")
    :title("Read & Cast (Halts)")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#820082"), vectors.hexToRGB("#6f4fab"))
      changeSpell("cadhalt")
    end)
  hexPage:newAction()
    :item("hexcasting:battery")
    :title("Recharge Item")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#b38ef3"), vectors.hexToRGB("#ebaa4e"))
      changeSpell("recharge")
    end)
   
  hexPage:newAction(9)
    :item("minecraft:shield")
    :title("Orbiters")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#5d4627"), vectors.hexToRGB("#777777"))
      changeSpell("orbiters")
    end)    
  hexPage:newAction(10)
    :item("minecraft:spectral_arrow")
    :title("Missile Burst")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#8d6acc"), vectors.hexToRGB("#732303"))
      changeSpell("missiles")
    end) 
    
  hexPage:newAction(11)
    :item("botania:brewery"):title("Botanian Brewbelt")
    :onLeftClick(function() changeSpell(BrewBelt) end)
    :onRightClick(function() action_wheel:setPage(ModPageBB) end)
  BrewBelt = {
    name="Brew Belt", id="brew",
    hue1="dbdbc7", hue2="2599a3",
    nick="§1BB", poseAnim="",
    mods={
        0, --[slowfall, fire res, resistance, water breathing, strength, haste, regen, invis, speed]
        1, --effect potency (currently static)
        2 --armor strength 
    } 
  }
  local brewNames = {"Vanity's Emptiness", "Bloodthirst", "Feather Feet", "Crossed Souls", "Allure"}  
  ModPageBB = action_wheel:newPage()
        --Augment Modifiers--
  ModPageBB:newAction()
    :item("botania:brewery"):title("Change Buff")
    :onLeftClick(function() 
      BrewBelt.mods[1]=(BrewBelt.mods[1]+1)%5  
      host:setActionbar("§1Augment Bestows: §b"..brewNames[(BrewBelt.mods[1]%9)+1])
    end)
    :onRightClick(function() 
      BrewBelt.mods[1]=(BrewBelt.mods[1]-1)%5  
      host:setActionbar("§1Augment Bestows: §b"..brewNames[(BrewBelt.mods[1]%9)+1])
    end)
  ModPageBB:newAction()
    :item("minecraft:chainmail_chestplate"):title("Armor Value")
    :onLeftClick(function() 
      BrewBelt.mods[3]=math.min(BrewBelt.mods[3]+1, 10)  
      host:setActionbar("§1Armor Potency: §b"..BrewBelt.mods[3])
    end)
    :onRightClick(function() 
      BrewBelt.mods[3]=math.max(BrewBelt.mods[3]-1, 0)  
      host:setActionbar("§1Armor Potency: §b"..BrewBelt.mods[3])
    end)
  
    --color each action
    for i,v in pairs(hexPage:getActions()) do v:hoverColor(vectors.hexToRGB("#462451")) end

  end