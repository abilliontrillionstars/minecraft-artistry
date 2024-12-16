if client.getVersion() == "1.19.2" then

  hexPage = action_wheel:newPage()

  CadCont = {
    name="Read & Cast (Continuous)", id="cadcont",
    hue1="820082", hue2="cfa0f3",
    nick="§6C§dC", poseAnim="", 
    mods={}
  }
  hexPage:newAction()
    :item("hexcasting:trinket"):title("Read & Cast (Continuous)")
    :onLeftClick(function() ChangeSpell(CadCont) end)
  CadHalt = {
    name="Read & Cast (Halts)", id="cadhalt",
    hue1="820082", hue2="6f4fab",
    nick="§6C§5C", poseAnim="", 
    mods={}
  }
  hexPage:newAction()
    :item("hexcasting:cypher"):title("Read & Cast (Halts)")
    :onLeftClick(function() ChangeSpell(CadHalt) end)
  RechargeItem = {
    name="Recharge Item", id="recharge",
    hue1="b38ef3", hue2="ebaa4e",
    nick="§1R", poseAnim="", 
    mods={}
  }
  hexPage:newAction()
    :item("hexcasting:battery"):title("Recharge Item")
    :onLeftClick(function() ChangeSpell(RechargeItem) end)
  Orbiters = {
    name="Orbiters", id="orbiters",
    hue1="5d4627", hue2="777777",
    nick="§7OS", poseAnim="poseRaiseStaff", 
    mods={}
  }
  hexPage:newAction(9)
    :item("minecraft:shield"):title("Orbiters")
    :onLeftClick(function() ChangeSpell(Orbiters) end)   
  MissileBurst = {
    name="Missile Burst", id="missiles",
    hue1="8d6acc", hue2="732303",
    nick="§dM§6B", poseAnim="posePush", 
    mods={}
  }
  hexPage:newAction(10)
    :item("minecraft:spectral_arrow"):title("Missile Burst")
    :onLeftClick(function() ChangeSpell(MissileBurst) end) 
    
  
  BrewBelt = {
    name="Brew Belt", id="brew",
    hue1="dbdbc7", hue2="2599a3",
    nick="§1B§dB", poseAnim="poseRaiseStaff",
    mods={
        0, --[slowfall, fire res, resistance, water breathing, strength, haste, regen, invis, speed]
        1, --effect potency (currently static)
        2 --armor strength 
    } 
  }
  hexPage:newAction(11)
    :item("botania:brewery"):title("Botanian Brewbelt")
    :onLeftClick(function() ChangeSpell(BrewBelt) end)
    :onRightClick(function() action_wheel:setPage(ModPageBB) end)

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
  
    Pumpkill = {
      name="Pumpkin Bombtrap", id="pumpkill",
      hue1="975c13", hue2="999999",
      nick="§6P§eB", poseAnim="posePush",
      mods={} 
    }
    hexPage:newAction(12)
      :item("minecraft:pumpkin"):title("Pumpkin Bombtrap")
      :onLeftClick(function() ChangeSpell(Pumpkill) end)

    DripstoneRing = {
        name="Dripstone Plate", id="dripstonearea",
        hue1="6e5347", hue2="3a4c26",
        nick="§6D§8P", poseAnim="poseRaiseStaffSlam",
        mods={} 
      }
      hexPage:newAction(13)
        :item("minecraft:dripstone_block"):title(DripstoneRing.name)
        :onLeftClick(function() ChangeSpell(DripstoneRing) end)
    
    Transplace = {
        name="Transplace", id="transplace",
        hue1="a45dde", hue2="422d97",
        nick="§dT§5P", poseAnim="poseRaiseStaff",
        mods={} 
      }
      hexPage:newAction(14)
        :item("minecraft:ender_pearl"):title(Transplace.name)
        :onLeftClick(function() ChangeSpell(Transplace) end)
    
  
    --color each action
    for i,v in pairs(hexPage:getActions()) do v:hoverColor(vectors.hexToRGB("#462451")) end
  end