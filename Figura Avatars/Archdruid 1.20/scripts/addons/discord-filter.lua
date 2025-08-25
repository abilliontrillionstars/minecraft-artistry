local BLOCKLIST = {}
BLOCKALL = false

-- replace with = false to silence completely
local blockedIndicator = toJson {
    text = "-- blocked message --",
    color = "dark_gray"
}

function events.chat_receive_message(msg, json)
    if msg:match("^%[lua%]") then return end
    local ok, val = pcall(parseJson, json)
    if not ok then return nil end
    if val.text and val.text == "[@" then
        if not (val.extra and val.extra[1] and val.extra[1].clickEvent) then return end
        local click = val.extra[1].clickEvent
        if click.action ~= "suggest_command" then return end
        if BLOCKLIST[click.value] then return blockedIndicator end
    end
end