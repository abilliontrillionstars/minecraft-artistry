HUD = models.aduene.Hud

HUD:setVisible(true)
HUD.crosshair:setVisible(false)
local screendims = client:getScaledWindowSize()
HUD:setPos(screendims[1]/-2, screendims[2]/-2, 0)
HUD:setScale(1)

function events.render(delta, mode)
    if LMBDown then 
        HUD.leftMouse:setOpacity(1)
        HUD.leftMouse:setScale(1.1)
        HUD.rightMouse:setOpacity(1)
        HUD.rightMouse:setScale(1.1)
    else 
        HUD.leftMouse:setOpacity(0.5)
        HUD.leftMouse:setScale(1)
        HUD.rightMouse:setOpacity(0.5)
        HUD.rightMouse:setScale(1)
    end
    local anims = animations:getPlaying()[1]
    renderer:setForcePaperdoll(anims)
end
