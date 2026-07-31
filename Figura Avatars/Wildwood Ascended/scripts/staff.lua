
-- purpose of this file is to handle rendering of the staff item

function events.item_render(item, mode)
    if item:getID():find("hexcasting:staff") 
    or mode=="THIRD_PERSON_RIGHT_HAND" then
        return models.aduene.ItemStaff:setPos(0,0,1):setRot()
    end
end


