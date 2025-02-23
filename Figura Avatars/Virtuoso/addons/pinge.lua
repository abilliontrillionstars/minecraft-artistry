local username = "just_laniakea"
local nick = "lani"

function events.chat_receive_message(message, asJson) 
    --if message:find("[lua]") then return end
    --if message:find("test") and not message:find("{") then
      --   print(asJson) end

    if asJson:find("Wheel#31ff8594") then return end

    message=string.lower(message)
    if message:find(nick) and not (message:find("<"..username..">") or message:find("<#"..username..">") or message:find("<"..username.." @Wheel>")) and player:isLoaded() then
        pitch=math.random(3,9)/10
        pings.sfx("entity.experience_orb.pickup",  pitch)
        pings.sfx("entity.experience_orb.pickup",  pitch*2)
    end 
end
