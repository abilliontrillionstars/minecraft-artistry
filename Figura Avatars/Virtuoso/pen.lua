PENDOWN = false
PENCOLOR = vec(1,1,1)
function pings.setPen(toggle) PENDOWN=toggle end

function events.mouse_press(button, action)
    --action: 0 for UP, 1 for DOWN
    if host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting" then    
        if action==1 then 
            pings.setPen(true)
        elseif action==0 then 
            pings.setPen(false)
        end
    end
end

function events.tick()
    if PENDOWN then
        local posit
        if models.iris.AnimBrush:getVisible() then
            posit = models.iris.AnimBrush.physBoneBrushTip2.physBoneBrushTipTip2.springForce3:partToWorldMatrix():apply()
        else
            posit = models.iris.ItemBrush.physBoneBrushTip.physBoneBrushTipTip.springForce:partToWorldMatrix():apply()
        end
            confetti.newParticle("inkdot", posit, nil,
        {
            billboard=true,
            ticker = function (particle) 
                confetti.defaultTicker(particle)
                particle.task:setColor(PENCOLOR) 
            end
        })
    end
end
