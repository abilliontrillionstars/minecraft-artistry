confetti = require("addons.confetti")
require("pen")

vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
--vanilla_model.ALL:setVisible(false)
models.iris.root:setVisible(true)
models.iris.ItemBrush:setVisible(true)
models.iris.ItemBrush.handleExtend:setVisible(false)
models.iris.AnimBrush:setVisible(false)
models.iris.AnimBrush.holdPivot.handleExtend:setVisible(false)

confetti.registerSprite("inkdot", textures["textures.ink_particle"], vec(0,0,0,0), 20)
confetti.registerSprite("inkblot", textures["textures.ink_particle"], vec(0,0,0,0), 10)
confetti.registerSprite("inksplotch", textures["textures.ink_particle"], vec(0,0,0,0), 10)

function pings.playAnim(anim) 
    if animations.iris[anim]:getLoop()=="LOOP" then
      animations.iris[anim]:setPlaying(true)
    else
      animations.iris[anim]:play()
    end
end
function pings.stopAnim(anim) 
    if animations.iris[anim]:getLoop()=="LOOP" then
      animations.iris[anim]:setPlaying(false)
    else
      animations.iris[anim]:stop()
    end
end

BRUSHMODE = "WAND"
function pings.ToggleBrushStaff()
    if BRUSHMODE=="WAND" then
        animations.iris["brushToStaff"]:play()
    else
        animations.iris["brushToWand"]:play()
    end
end
function pings.ColorApron(color)
    models.iris.root.LeftLeg.overall:setColor(color)
    models.iris.root.LeftLeg.pocket:setColor(color)
    models.iris.root.LeftLeg.overallFlap:setColor(color)
    models.iris.root.RightLeg.overall:setColor(color)
    models.iris.root.RightLeg.pocket:setColor(color)
    models.iris.root.RightLeg.overallFlap:setColor(color)
    models.iris.root.Body.overall:setColor(color)
    avatar:setColor(color)
    if player:isLoaded() then 
        sounds:playSound("minecraft:entity.zombie_villager.converted", player:getPos(), 0.3, 7 + (math.random(-4,4)/10))
        sounds:playSound("minecraft:entity.zombie_villager.converted", player:getPos(), 0.05, 5 + (math.random(-4,4)/10))
    end
    avatar:store("pigment", color)

    PENCOLOR=color
end

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

mainPage:newAction()
    :title("Test Apron Color"):item("botania:spectrolus")
    :onLeftClick(function () pings.ColorApron(vec(math.random(), math.random(), math.random())) end)
mainPage:newAction()
    :title("Chloe Apron Color"):item("botania:spectranthemum")
    :onLeftClick(function () pings.ColorApron(vectors.hexToRGB("#69c67c")) end)
mainPage:newAction()
    :title("Test Brush-Staff"):item("lanishextendedstaves:extended_staff_spruce")
    :onLeftClick(function () pings.ToggleBrushStaff() end)
mainPage:newAction(9)
    :title("Test Casting Anim"):item("minecraft:end_portal_frame")
    :onLeftClick(function () pings.playAnim("testStaffOrbit1") end)




function events.item_render(item, mode)
    if item:getID():find("staff") or item:getID()=="spectrum:paintbrush" or item:getID()=="hexgloop:casting_ring" then 
        if host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting" and BRUSHMODE=="WAND" then
            return models.iris.ItemBrush:setRot(-45,0,0)
        else
            return models.iris.ItemBrush:setRot(-15,0,0) 
        end
    end
end
