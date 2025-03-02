--[[
local tex = textures:newTexture("white", 1, 1)
tex:fill(0, 0, 1, 1, 1, 1, 1, 1)
tex:update()

local HUD = models.iris.HUD

local COLORS = {
    ["spectrum:black"] = vec(0.00784313725490196, 0.00392156862745098, 0.0235294117647059, 1),
    ["spectrum:blue"] = vec(0.141176470588235, 0.196078431372549, 1, 1),
    ["spectrum:brown"] = vec(0.43921568627451, 0.250980392156863, 0.0509803921568627, 1),
    ["spectrum:cyan"] = vec(0.356862745098039, 1, 0.929411764705882, 1),
    ["spectrum:gray"] = vec(0.274509803921569, 0.274509803921569, 0.274509803921569, 1),
    ["spectrum:green"] = vec(0.32156862745098, 0.419607843137255, 0.0588235294117647, 1),
    ["spectrum:light_blue"] = vec(0.47843137254902, 0.619607843137255, 1, 1),
    ["spectrum:light_gray"] = vec(0.67843137254902, 0.67843137254902, 0.67843137254902, 1),
    ["spectrum:lime"] = vec(0.596078431372549, 1, 0.215686274509804, 1),
    ["spectrum:magenta"] = vec(1, 0.309803921568627, 0.964705882352941, 1),
    ["spectrum:orange"] = vec(1, 0.388235294117647, 0.0117647058823529, 1),
    ["spectrum:pink"] = vec(1, 0.623529411764706, 0.776470588235294, 1),
    ["spectrum:purple"] = vec(0.501960784313726, 0.168627450980392, 0.768627450980392, 1),
    ["spectrum:red"] = vec(1, 0, 0.0509803921568627, 1),
    ["spectrum:white"] = vec(1, 1, 1, 1),
    ["spectrum:yellow"] = vec(0.929411764705882, 0.929411764705882, 0, 1),
}

function events.render(delta)
    local winSize = client:getScaledWindowSize()
    local group = HUD["ink_levels"]
    if group == nil then
        group = HUD:newPart("ink_levels")
    end
    local palette = player:getNbt().cardinal_components["trinkets:trinkets"].legs.pigment_palette.Items[1]
    if palette.id ~= "spectrum:pigment_palette" then
        group:remove()
        return
    end
    local inks = palette.tag.EnergyStore.Energy
    local curY = -8*16 +4
    group:setOpacity(0.5)
    for key, value in pairs(inks) do
        if true then
            local bgcolor = vectors.rgbToHSV(COLORS[key].rgb)
            bgcolor.z = 0.5
            local bg = group:newSprite(key .. ":bg")
            bg:setTexture(tex)
            bg:setSize(64, 8)
            bg:setPos(-4, curY, 1)
            bg:setRot(0, 0, 0)
            bg:setColor(vectors.hsvToRGB(bgcolor))
            local bar = group:newSprite(key .. ":fg")
            bar:setTexture(tex)
            bar:setSize(value / 6400, 8)
            bar:setPos(-4, curY, 0)
            bar:setRot(0, 0, 0)
            bar:setColor(COLORS[key])
            local text = group:newText(key .. ":amt")
            text:setText(math.floor(value/100)/10 .."k")
            text:setPos(-64 -12, curY, 0)
            text:setRot(0, 0, 0)
            curY = curY + 8
        end
    end
end
]]--