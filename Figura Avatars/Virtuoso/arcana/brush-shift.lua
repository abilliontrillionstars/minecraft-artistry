

local brushSkins = {"staff", "spectrum:paintbrush"}





BRUSHMODE = "WAND" --either WAND or STAFF
function pings.ToggleBrushStaff()
    if BRUSHMODE=="WAND" then
        animations.iris["brushToStaff"]:play()
    else
        animations.iris["brushToWand"]:play()
    end
end


function events.item_render(item, mode)
    if item:getID():find("staff") or item:getID()=="spectrum:paintbrush" or item:getID()=="hexgloop:casting_ring" then 
        if host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting" and BRUSHMODE=="WAND" then
            return models.iris.ItemBrush:setRot(-45,0,0)
        else
            return models.iris.ItemBrush:setRot(-15,0,0) 
        end
    end
end
