local username = "just_laniakea"
local nick = "lani"

function events.chat_receive_message(message, asJson) 
    if message:find("[lua]") then return end
    --print(message)
    message= string.lower(message)
    if message:find(nick) and not (message:find("<"..username..">") or message:find("<#"..username..">")) and player:isLoaded() then
        pings.sfx("entity.experience_orb.pickup",  0.5+math.random(0,4)/10)
        pings.sfx("entity.experience_orb.pickup",  0.2+math.random(0,4)/10)
    end 
end
  