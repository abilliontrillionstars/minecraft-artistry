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
        local posit = models.iris.ItemBrush.physBoneBrushTip.physBoneBrushTipTip.springForce:partToWorldMatrix():apply()
        confetti.newParticle("inkdot", posit, nil,{
            billboard=true,
            ticker = function (particle) 
                confetti.defaultTicker(particle)
                particle.task:setColor(PENCOLOR)
            end
        })
    end
end
