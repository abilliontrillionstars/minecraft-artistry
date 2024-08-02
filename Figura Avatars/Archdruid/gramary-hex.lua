if client.getVersion() == "1.19.2" then

  hexPage = action_wheel:newPage()

  hexPage:newAction()
      :item("botania:spectrolus")
      :title("Leaf Color Test")
      :onLeftClick(function() 
        pings.colorStaff(vec(math.random(0,255), math.random(0,255), math.random(0,255)), vec(math.random(0,255), math.random(0,255), math.random(0,255))) 
      end)
  hexPage:newAction()
    :item("minecraft:blaze_powder")
    :title("Particle Test")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#820082"), vectors.hexToRGB("#820082"))
      host:sendChatMessage("!particle")
    end)
  hexPage:newAction()
    :item("hexcasting:trinket")
    :title("Read & Cast (Continuous)")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#820082"), vectors.hexToRGB("#cfa0f3"))
      host:sendChatMessage("!cadcont")
    end)
  hexPage:newAction()
    :item("hexcasting:cypher")
    :title("Read & Cast (Halts)")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#820082"), vectors.hexToRGB("#6f4fab"))
      host:sendChatMessage("!cadhalt")
    end)
    hexPage:newAction()
    :item("hexcasting:battery")
    :title("Recharge Item")
    :onLeftClick(function() 
      pings.colorStaff(vectors.hexToRGB("#b38ef3"), vectors.hexToRGB("#ebaa4e"))
      host:sendChatMessage("!recharge")
    end)
    --color each action

    for i,v in pairs(hexPage:getActions()) do v:hoverColor(vectors.hexToRGB("#462451")) end

  end