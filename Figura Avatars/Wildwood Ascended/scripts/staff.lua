-- purpose of this file is to handle rendering of the staff item
HasStaff = false

function events.item_render(item, mode)
    if item:getID():find("hexcasting:staff") then
        return models.aduene.ItemStaff:setPos(0,0,1):setRot()
    end
end

function events.render(item)
    -- get offhand
    item = player:getHeldItem(true)
    if item:getID():find("hexcasting:staff") then
        if hasStaff then
            -- falling edge
        end
        HasStaff = true
    else
        if not hasStaff then
            -- rising edge
        end
        HasStaff = false
    end
end
