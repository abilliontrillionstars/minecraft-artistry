
STARRY_FORM = false

local starryParts = {
    models.aduene.root.Body.Body,
    models.aduene.root.Head.Head,
    models.aduene.root.LeftLeg.LeftLeg,
    models.aduene.root.RightLeg.RightLeg,
    models.aduene.root.LeftArm.LeftArm,
    models.aduene.root.RightArm.RightArm,
}
local shinyParts = {
    models.aduene.root.Head.Hat,
    models.aduene.root.Body.Mantle,
    models.aduene.root.LeftArm.mantleLeft,
    models.aduene.root.RightArm.mantleRight,
    models.aduene.root.Elytra.LeftElytra,
    models.aduene.root.Elytra.RightElytra,
}
local outlineParts = {
    models.aduene.root.Body.Outline,
    models.aduene.root.Head.Outline,
    models.aduene.root.LeftLeg.Outline,
    models.aduene.root.RightLeg.Outline,
    models.aduene.root.LeftArm.Outline,
    models.aduene.root.RightArm.Outline,
}
for _,modelpart in pairs(outlineParts) do
    modelpart:setPrimaryRenderType("CUTOUT_CULL")
    modelpart:setSecondaryRenderType("EMISSIVE")
end
models.aduene.root.Head.StarryHead:setPrimaryRenderType("EMISSIVE")

function pings.StarryForm(state)
    --models["starry-form"]:setVisible(state)
    models.aduene.root.LeftLeg["Left Pants"]:setVisible(not state)
    models.aduene.root.RightLeg["Right Pants"]:setVisible(not state)
    for _,modelpart in pairs(outlineParts) do
        modelpart:setVisible(state)
    end
    models.aduene.root.Head.StarryHead:setVisible(state)
    
    if state then
        for _,modelpart in pairs(starryParts) do
            modelpart:setPrimaryTexture("custom", textures["textures.stars"])
            modelpart:setPrimaryRenderType("TEXTURED_PORTAL")
        end
        models.aduene.root.Head.Hat:setPrimaryTexture("custom", textures["textures.starry-features"])
        for _,modelpart in pairs(shinyParts) do
            modelpart:setPrimaryRenderType("EMISSIVE")
            modelpart:setOpacity(0.5)
        end
    else
        for _,modelpart in pairs(starryParts) do
            modelpart:setPrimaryTexture("custom", textures["textures.skin"])
            modelpart:setPrimaryRenderType("TRANSLUCENT")
        end
        models.aduene.root.Head.Hat:setPrimaryTexture("custom", textures["textures.skin"])
        for _,modelpart in pairs(shinyParts) do
            modelpart:setPrimaryRenderType("TRANSLUCENT")
            modelpart:setOpacity(1)
        end
    end
    STARRY_FORM = state
end

DoRings = true
function events.render(delta)
    if avatar:getRemainingParticles()>15 and player:isLoaded() and STARRY_FORM and DoRings then
        local var = (delta+world:getTime())*(2*math.pi)/10
        particles:newParticle("hexcasting:conjure_particle 1",  
          player:getPos()+vec(math.sin(var)*1.5,1,math.cos(var)*1.5))
          :setColor(1,1,1)
        var = var/2
        particles:newParticle("hexcasting:conjure_particle 1",  
          player:getPos()+vec(math.sin(var)*4,1,math.cos(var)*-4))
          :setColor(1,1,1)
    end
end