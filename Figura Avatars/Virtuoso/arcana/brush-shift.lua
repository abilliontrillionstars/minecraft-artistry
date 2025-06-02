

local brushSkins = {}
--brushSkins["staff"] = ""
brushSkins["spectrum:paintbrush"] = models.iris.ItemBrush
--brushSkins["hexcasting:spellbook"] = models.iris.ItemSpellbook:setRot(30,0,0)




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
        elseif AnimsPlaying() then
            return models.iris.ItemBrush:setRot(0,0,0)
        else
            return models.iris.ItemBrush:setRot(0,0,0)
        end
    end


    if id == "hexcasting:spellbook" then 
        if mode:find("FIRST") then 
            if mode:find("LEFT") then return models.iris.ItemPalette:setRot(-15,180,0)
            else return models.iris.ItemPalette:setRot(15,0,0) end 
        elseif mode:find("THIRD") then 
            return models.iris.ItemPalette:setRot(90,15,100):setPos(-1,4,0) end
      end
end
