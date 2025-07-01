CastSound = "Staff percusses"  

function events.on_play_sound(id, pos, vol, pitch, loop, cat, path)
    -- if there's no path, it's a Figura sound, so we ignore those
    --print(id)
    
    if path and player:isLoaded() then
      --replace casting noises with the staff percussion hit
      if (pos - player:getPos()):length()<3 
      and (id == "hexcasting:casting.pattern.add_segment" or id == "hexcasting:casting.pattern.start") then
        sounds:playSound(CastSound, player:getPos(), 0.4, (math.random(20,30)/100))
        return true
      end
    end
end