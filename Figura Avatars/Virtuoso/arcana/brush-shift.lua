

local brushSkins = {}
--brushSkins["staff"] = ""
brushSkins["spectrum:paintbrush"] = models.iris.ItemBrush




BRUSHMODE = "WAND" --either WAND or STAFF
function pings.ToggleBrushStaff()
    if BRUSHMODE=="WAND" then
        animations.iris["brushToStaff"]:play()
    else
        animations.iris["brushToWand"]:play()
    end
end


function events.item_render(item, mode)
    local id = item:getID()
    if brushSkins[id] then return brushSkins[id] end
    if id:find("staff") and id:find("hexcasting") then
        if host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting" and BRUSHMODE=="WAND" then
            return models.iris.ItemBrush:setRot(-45,0,0)
        else
            return models.iris.ItemBrush:setRot(-15,0,0) 
        end
    end
end
