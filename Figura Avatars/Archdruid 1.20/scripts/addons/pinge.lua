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
  range={(0.8*1.25), 0.8, 1.2}
  pitch=range[math.random(1,3)]
  if player:isLoaded() then
    sounds:playSound("block.note_block.guitar", player:getPos(), 1, pitch*0.25)
    sounds:playSound("block.note_block.guitar", player:getPos(), 1, pitch)
    sounds:playSound("block.note_block.guitar", player:getPos(), 1, pitch*1.5)
    sounds:playSound("block.note_block.guitar", player:getPos(), 1, pitch*2)
  end
end
