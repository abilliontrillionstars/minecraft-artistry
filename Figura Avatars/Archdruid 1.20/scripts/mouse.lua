CAPTURE_MOUSE_BUTTONS = true
LMBDown = false
RMBDown = false
MMBDown = false
LMBCharge = -1
RMBCharge = -1
MMBCharge = -1
function events.mouse_press(button, action)
  if action==1 then
    if button==0 then
      LMBDown = true
    elseif button==1 then
      RMBDown = true
    elseif button==2 then
      MMBDown = true
    end
  else
    if button==0 then
      LMBDown = false
    elseif button==1 then
      RMBDown = false
    elseif button==2 then
      MMBDown = false
    end
  end
  return CAPTURE_MOUSE_BUTTONS
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
end

