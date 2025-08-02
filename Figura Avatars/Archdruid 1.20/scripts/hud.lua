HUD = models.aduene.Hud

HUD:setVisible(true)
local screendims = client:getScaledWindowSize()
HUD:setPos(screendims[1]/-2, screendims[2]/-2, 0)
HUD:setScale(1)

function events.render(delta, mode)
    if LMBDown then 
        HUD.leftMouse:setOpacity(1)
        HUD.leftMouse:setScale(1.1)
    else 
        HUD.leftMouse:setOpacity(0.5)
        HUD.leftMouse:setScale(1)
    end
    if RMBDown then 
        HUD.rightMouse:setOpacity(1)
        HUD.rightMouse:setScale(1.1)
    else 
        HUD.rightMouse:setOpacity(0.5)
        HUD.rightMouse:setScale(1)
    end
    if MMBDown then 
        HUD.middleMouse:setOpacity(1)
        HUD.middleMouse:setScale(1.1)
    else 
        HUD.middleMouse:setOpacity(0.5)
        HUD.middleMouse:setScale(1)
    end

    host:setActionbar("("..CHARGE_MODE.." : "..CHARGE_TIME..")")

    HUD.crosshair:setVisible(mode=="FIRST_PERSON")

    local anims = animations:getPlaying()[1]
    renderer:setForcePaperdoll(anims)
end
