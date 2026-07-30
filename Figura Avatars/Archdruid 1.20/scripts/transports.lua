--[[
function server_packets.transport_received(data)
    local type = data:read() -- 1 byte
    --print(type)
    -- vector
    if type == 7 then -- vector
        local x = data:readDouble()
        local y = data:readDouble()
        local z = data:readDouble()

        local v = vec(x,y,z)
        print(v)
        
        -- send back a bool
        data:clear()
        data:setPosition(0)
        if v == player:getPos() then
            data:write(2)
        else
            data:write(3)
        end
        server_packets:sendPacket("transport_send", data)
    end

    -- plans, for posterity
        -- sending power is 8, (per what idk)
            -- send 8 vecs per tick (if per tick)
        -- avatar returns bools for each, 
        -- representing bfs branching.
        -- factors out predicates for bfs, so it can be 
        -- used for more complex predicates
            -- (i.e. checking nearby blocks and stuff can
            -- be done in lua, saving on ops)
            -- allows using shape predicates in conjunction
        -- 

    
end
]]--
