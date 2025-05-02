confetti = require("addons.confetti")
confetti.registerSprite("inkdot", textures["textures.ink_particle"], vec(0,0,0,0), 20)
confetti.registerSprite("inkblot", textures["textures.ink_particle"], vec(2,2,-1,-1), 20)
confetti.registerSprite("inksplotch", textures["textures.ink_particle"], vec(3,3,-1,-1), 20)

PENDOWN = false
PENCOLOR = vec(1,1,1)
PENCOLOR_DYE_STRING = "white"
VANILLA_COLORS = {
    black = vec(0.00784313725490196, 0.00392156862745098, 0.0235294117647059),
    blue = vec(0.141176470588235, 0.196078431372549, 1),
    brown = vec(0.43921568627451, 0.250980392156863, 0.0509803921568627),
    cyan = vec(0.356862745098039, 1, 0.929411764705882),
    gray = vec(0.274509803921569, 0.274509803921569, 0.274509803921569),
    green = vec(0.32156862745098, 0.419607843137255, 0.0588235294117647),
    light_blue = vec(0.47843137254902, 0.619607843137255, 1),
    light_gray = vec(0.67843137254902, 0.67843137254902, 0.67843137254902),
    lime = vec(0.596078431372549, 1, 0.215686274509804),
    magenta = vec(1, 0.309803921568627, 0.964705882352941),
    orange = vec(1, 0.388235294117647, 0.0117647058823529),
    pink = vec(1, 0.623529411764706, 0.776470588235294),
    purple = vec(0.501960784313726, 0.168627450980392, 0.768627450980392),
    red = vec(1, 0, 0.0509803921568627),
    white = vec(1, 1, 1),
    yellow = vec(0.929411764705882, 0.929411764705882, 0),
}
PENWIDTH = 1
PEN_OVERRIDE = "hex"


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
function DrawParticle()

    if models.iris.AnimBrush:getVisible() then
        posit = models.iris.AnimBrush.holdPivot.physBoneBrushTip2.physBoneBrushTipTip2.springForce3:partToWorldMatrix():apply()
    else
        posit = models.iris.ItemBrush.holdPivot2.physBoneBrushTip.physBoneBrushTipTip.springForce:partToWorldMatrix():apply()
    end
    if not PEN_OVERRIDE then
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
    else
        particles:newParticle("hexcasting:conjure_particle 1", posit):setColor(PENCOLOR)

        particles:newParticle("hexcasting:conjure_particle 1", lastposit+(lastposit - posit)/2):setColor(PENCOLOR)
    end
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

function events.tick()
    isCasting = host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting"
    if PENDOWN then
        DrawParticle()
    end
    lastposit = posit
end