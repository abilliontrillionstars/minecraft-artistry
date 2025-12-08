CAPTURE_MOUSE_BUTTONS = true
LastCancel = false
LMBDown = false
RMBDown = false
MMBDown = false
LMBCharge = -1
RMBCharge = -1
MMBCharge = -1
function events.mouse_press(button, action)
  if not CAPTURE_MOUSE_BUTTONS then return end
  LastCancel = host:getScreen()==nil and not action_wheel:isEnabled()
  and ((host:getSlot("weapon.offhand"):getID() == "minecraft:air" and button==1)
  or (host:getSlot("weapon.mainhand"):getID() == "minecraft:air") and button==0)
  or button==2 -- MMB doesn't use the hands
  
  if not LastCancel then return end
  if action==1 then
    if button==0 then
      LMBDown = true
    elseif button==1 then
      RMBDown = true
    elseif button==2 then
      MMBDown = true
    end
  elseif action==0 then
    if button==0 then
      LMBDown = false
    elseif button==1 then
      RMBDown = false
    elseif button==2 then
      MMBDown = false
    end
  end
  return LastCancel
end

function events.tick()
    if LMBDown then
      LMBCharge = LMBCharge+1
    else
      LMBCharge = -1
    end
    if RMBDown then
      RMBCharge = RMBCharge+1
    else
      RMBCharge = -1
    end
    if MMBDown then
      MMBCharge = MMBCharge+1
    else
      MMBCharge = -1
    end
    RunState()
end

