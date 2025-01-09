confetti = require("addons.confetti")
confetti.registerSprite("inkdot", textures["iris.ink_particle"], vec(0,0,0,0), 20)
confetti.registerSprite("inkblot", textures["iris.ink_particle"], vec(2,2,-1,-1), 20)
confetti.registerSprite("inksplotch", textures["iris.ink_particle"], vec(3,3,-1,-1), 20)

PENDOWN = false
PENCOLOR = vec(1,1,1)
PENWIDTH = 1

local isCasting = host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting"

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

local lastposit = vec(0,0,0)
local posit = vec(0,0,0)
local ptcl
function events.tick()
    isCasting = host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting"
    if PENDOWN then
        if models.iris.AnimBrush:getVisible() then
            posit = models.iris.AnimBrush.holdPivot.physBoneBrushTip2.physBoneBrushTipTip2.springForce3:partToWorldMatrix():apply()
        else
            posit = models.iris.ItemBrush.physBoneBrushTip.physBoneBrushTipTip.springForce:partToWorldMatrix():apply()
        end
        if (posit - lastposit):length() > 0.3 and not isCasting then
            ptcl = "inksplotch" 
            --make a particle in between the two
            confetti.newParticle("inkblot", lastposit+(lastposit - posit)/2, 
                vec(math.random(),math.random(),math.random())/1000,
                {billboard=true}
            ).task:setColor(PENCOLOR):setRot(0,0,math.random(-100,100))
        elseif (posit - lastposit):length() > 0.2 then
            ptcl = "inkblot"
        else
            ptcl = "inkdot"
        end
        
        confetti.newParticle(ptcl, posit, 
            vec(math.random(),math.random(),math.random())/1000,
        {billboard=true,}
        ).task:setColor(PENCOLOR):setRot(0,0,math.random(-100,100))
    end
    lastposit = posit
end

function events.WORLD_RENDER(delta)
    --[[
    if PENDOWN and not isCasting then
        if models.iris.AnimBrush:getVisible() then
            posit = models.iris.AnimBrush.holdPivot.physBoneBrushTip2.physBoneBrushTipTip2.springForce3:partToWorldMatrix():apply()
        else
            posit = models.iris.ItemBrush.physBoneBrushTip.physBoneBrushTipTip.springForce:partToWorldMatrix():apply()
        end
        if (posit - lastposit):length() > 0.2 and not isCasting then
            confetti.newParticle("inkblot", posit, 
                vec(math.random(),math.random(),math.random())/1000,
            {billboard=true,}
            ).task:setColor(PENCOLOR):setRot(0,0,math.random(-100,100))
        end
    end
    ]]
end