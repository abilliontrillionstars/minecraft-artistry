local jimmy = require("scripts.libs.EZAnims")
local wildwood = jimmy:addBBModel(animations.aduene)
local hasStaff = false
function events.render(item)
    -- get offhand
    item = player:getHeldItem(true)
    if item:getID():find("hexcasting:staff") then
        if hasStaff then
            wildwood:setState("hasStaff")
        end
        hasStaff = true
    else
        if not hasStaff then
            wildwood:setState()
        end
        hasStaff = false
    end
end

-- patch: stop the walk animation if I'm not pressing w --
local wPressed = false
function events.key_press(key, action)
  if key==87 then 
    if action==0 and host:getScreen() == nil then
      pings.updateWPressed(false)
    elseif action==1 and host:getScreen() == nil then
      pings.updateWPressed(true)
    end
  end
end
function pings.updateWPressed(toggle) wPressed = toggle end
function events.render(delta, context)
  if not wPressed and animations.aduene.walk:isPlaying() then
    -- var in jimmyanims
    walking = false
  end
end