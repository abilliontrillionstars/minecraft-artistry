local teamchattoggle = {
    ["prefixes"] = {","},
    ["historyfix"] = true -- Should this script strip out "/ftbteams msg" from all messages? This means history works, but it might mess with scripts that send this.
}

local teamchat = false
events.entity_init:register(function()
    local togglekey = keybinds:newKeybind("Team Chat Toggle", "key.keyboard.y")
    togglekey.press = function()
        teamchat = not teamchat
        printJson(toJson {
            text = "Chat Toggle is now " .. (teamchat and "on" or "off"),
            color = teamchat and "#55FF55" or "#FF5555"
        })
    end
end)

events.chat_send_message:register(function(msg)
    if not msg then return msg end
    local messagecommand = "/ftbteams msg "
    if teamchattoggle.historyfix then
        if string.sub(msg, 1, #messagecommand) == messagecommand then
            msg = string.sub(msg, #messagecommand)
        end
    end
    if teamchat then
        local pass = true
        for i = 1, #teamchattoggle.prefixes do
            local prefix = teamchattoggle.prefixes[i]
            if string.sub(msg, 1, #prefix) == prefix then
                pass = false
            end
        end
        if pass then
            return messagecommand .. msg
        end
    end
    return msg
end)

return teamchattoggle
