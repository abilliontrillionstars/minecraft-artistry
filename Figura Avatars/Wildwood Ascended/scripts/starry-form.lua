
STARRY_FORM = false

local starryParts = {
    models.aduene.root.Body.stars,
    models.aduene.root.Body.Head.stars,
    models.aduene.root.LeftLeg.stars,
    models.aduene.root.RightLeg.stars,
    models.aduene.root.Body.LeftArm.stars,
    models.aduene.root.Body.RightArm.stars,
}

local shinyParts = {
    models.aduene.root.Body.Body,
    models.aduene.root.Body.Head.Head,
    models.aduene.root.Body.Head.Hat,
    models.aduene.root.LeftLeg.LeftLeg,
    models.aduene.root.RightLeg.RightLeg,
    models.aduene.root.Body.LeftArm.LeftArm,
    models.aduene.root.Body.RightArm.RightArm,


    models.aduene.root.Body.mantle.mantle,
    models.aduene.root.Body.mantle.cube1,
    models.aduene.root.Body.mantle.cube2,
    models.aduene.root.Body.mantle.gem,
    models.aduene.root.Body.LeftArm.mantleLeft,
    models.aduene.root.Body.RightArm.mantleRight,


    models.aduene.root.Body.Head.mask,
    models.aduene.root.Body.Head.physBoneHair,
    models.aduene.root.Body.Head.physBoneHair2,

    models.aduene.root.Body.RightArm["Right Sleeve"],
    models.aduene.root.Body.LeftArm["Left Sleeve"],
    models.aduene.root.Body.Jacket,
    models.aduene.root.LeftLeg["Left Pants"],
    models.aduene.root.RightLeg["Right Pants"]
}
--[[local outlineParts = {
    models.aduene.root.Body.Outline,
    models.aduene.root.Body.Head.Outline,
    models.aduene.root.LeftLeg.Outline,
    models.aduene.root.RightLeg.Outline,
    models.aduene.root.Body.LeftArm.Outline,
    models.aduene.root.Body.RightArm.Outline,
}
for _,modelpart in pairs(outlineParts) do
    modelpart:setPrimaryRenderType("CUTOUT_CULL")
    modelpart:setSecondaryRenderType("EMISSIVE")
end]]
--models.aduene.root.Head.StarryHead:setPrimaryRenderType("EMISSIVE")

function pings.StarryForm(state)
    --models["starry-form"]:setVisible(state)
    --for _,modelpart in pairs(outlineParts) do modelpart:setVisible(state) end
    --models.aduene.root.Head.StarryHead:setVisible(state)
    
    if state then
        for _,modelpart in pairs(starryParts) do
            modelpart:setScale(0.975)
            modelpart:setPrimaryTexture("custom", textures["textures.stars"])
            modelpart:setPrimaryRenderType("TEXTURED_PORTAL")
        end
        --models.aduene.root.Head.Hat:setPrimaryTexture("custom", textures["textures.starry-features"])
        for _,modelpart in pairs(shinyParts) do
            modelpart:setPrimaryRenderType("EMISSIVE")
            modelpart:setOpacity(0.25)
        end
    else
        for _,modelpart in pairs(starryParts) do
            modelpart:setPrimaryTexture("custom", textures["textures.skin"])
            modelpart:setPrimaryRenderType("TRANSLUCENT")
        end
        --models.aduene.root.Head.Hat:setPrimaryTexture("custom", textures["textures.skin"])
        for _,modelpart in pairs(shinyParts) do
            modelpart:setPrimaryRenderType("TRANSLUCENT")
            modelpart:setOpacity(1)
        end
    end
    STARRY_FORM = state
end


function pings.setDoRings(toggle)
    DoRings = toggle
end

DoRings = false
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