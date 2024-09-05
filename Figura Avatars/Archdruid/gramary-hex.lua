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
    
  BrewBelt = {
    name="Brew Belt", id="brew",
    hue1="45d17f", hue2="1c1c94",
    nick="§1A", poseAnim="",
    mods={
        0, --[slowfall, fire res, resistance, water breathing, strength, haste, regen, invis, speed]
        1 --buff potency 
    } 
  }
  local buffNames = {"Slowfalling", "Fire Resistance", "Resistance", "Water Breathing", "Strength", "Haste", "Regeneration", "Invisibility", "Speed"}
  ModPageA = action_wheel:newPage()
      --Augment Modifiers--
  ModPageA:newAction()
      :item("minecraft:brewing_stand"):title("Change Buff")
      :onLeftClick(function() 
          Augment.mods[1]=(Augment.mods[1]+1)%9  
          host:setActionbar("§aAugment Bestows§1: §0"..buffNames[(Augment.mods[1]%9)+1])
      end)
      :onRightClick(function() 
          Augment.mods[1]=(Augment.mods[1]-1)%9  
          host:setActionbar("§aAugment Bestows§1: §0"..buffNames[(Augment.mods[1]%9)+1])
      end)
  
    --color each action
    for i,v in pairs(hexPage:getActions()) do v:hoverColor(vectors.hexToRGB("#462451")) end

  end