local mishaps = {
    "Create Water:",
    "Break Block:",
    "Subtractive Distillation:",
}

function events.chat_receive_message(message, asJson) 
    if message:find("lua")
    then return asJson end

    if message:find("more Media than I had") then
        return false end
    for _, value in ipairs(mishaps) do
        if message:find(value) then
            host:setActionbar("§f[§dMishap hidden...§f]")
            if host:isHost() then sounds:playSound("minecraft:entity.generic.eat", player:getPos(), 0.5, 0.6) end
            return false
        end
    end
    message=string.lower(message)
end