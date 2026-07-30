
-- purpose of this file is to handle rendering of the staff item

function events.item_render(item, mode)
    local id = item:getID()
    if id:find("hexcasting:staff") then
        return models.aduene.ItemStaff:setPos(0,0,1):setRot()
    end
end


