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

    if message:find(nick) then
      pings.pling()
    end 
end

function pings.pling()
  pitch=math.random(3,9)/10
  if player:isLoaded() then
    sounds:playSound("block.note_block.bell", player:getPos(), 1, pitch)
    sounds:playSound("block.note_block.bell", player:getPos(), 1, pitch*1.25)
    sounds:playSound("block.note_block.bell", player:getPos(), 1, pitch*2)
  end
end
