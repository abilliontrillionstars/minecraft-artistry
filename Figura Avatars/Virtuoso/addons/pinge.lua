local username = "just_laniakea"
local nick = "lani"

function events.chat_receive_message(message, asJson) 
    if message:find("lua")
    then return asJson end

    if string.sub(message,1,1) == "<" then
      message = string.sub(message, message:find(">"), #message) end
    if string.sub(message,1,1) == "[" then
      message = string.sub(message, message:find("]"), #message) end

    message=string.lower(message)

    if message:find(nick) and player:isLoaded() then
        pitch=math.random(3,9)/10
        pings.sfx("block.note_block.bell",  pitch)
        pings.sfx("block.note_block.bell",  pitch*1.25)
        pings.sfx("block.note_block.bell",  pitch*2)
    end 
end
