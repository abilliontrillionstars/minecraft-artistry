
FILTER_DISCORD_GLOBAL = false
BLOCKED_DISCORD_USERS = {"codenredstone", "just_laniakea"}

function events.chat_receive_message(message, asJson) 
    if message:find("[lua]") then return asJson end
    if FILTER_DISCORD_GLOBAL and message:find("%[@") 
        then return end

    print("wah!")
    for i,v in pairs(BLOCKED_DISCORD_USERS) do
        print(v)
        if message:find("%[@")
        and message:find(v) then return end
    end
end