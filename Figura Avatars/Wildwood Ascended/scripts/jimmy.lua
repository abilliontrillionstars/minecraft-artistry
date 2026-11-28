local jimmy = require("scripts.libs.EZAnims")
local wildwood = jimmy:addBBModel(animations.aduene)

for _, anim in ipairs(animations:getAnimations()) do
  if anim.name:find("cast") then
    wildwood:addAllOverrider(anim)
  end
end

function events.render(item)
  if HasStaff then
    wildwood:setState("hasStaff")
  else
    wildwood:setState()
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