models["starry-form"]:setVisible(state)

local starryParts = {
    models["starry-form"].Head.Head,
    models["starry-form"].Body.Body,
    models["starry-form"].LeftArm.LeftArm,
    models["starry-form"].RightArm.RightArm,
    models["starry-form"].LeftLeg.LeftLeg,
    models["starry-form"].RightLeg.RightLeg
}

models["starry-form"]:setPrimaryRenderType("TRANSLUCENT")
models["starry-form"].Head.HeadLayer:setOpacity(0.75)
models["starry-form"].Head.HeadLayer:setPrimaryRenderType("EMISSIVE")
models["starry-form"].Head.HatLayer:setOpacity(0.75)
models["starry-form"].Head.HatLayer:setPrimaryRenderType("EMISSIVE")

models["starry-form"].Head.Outline:setPrimaryRenderType("CUTOUT_CULL")
models["starry-form"].Body.Outline:setPrimaryRenderType("CUTOUT_CULL")
models["starry-form"].LeftArm.Outline:setPrimaryRenderType("CUTOUT_CULL")
models["starry-form"].RightArm.Outline:setPrimaryRenderType("CUTOUT_CULL")
models["starry-form"].LeftLeg.Outline:setPrimaryRenderType("CUTOUT_CULL")
models["starry-form"].RightLeg.Outline:setPrimaryRenderType("CUTOUT_CULL")

for _,modelpart in pairs(starryParts) do
    modelpart:setPrimaryRenderType("TEXTURED_PORTAL")
end


function pings.StarryForm(state)
    models.aduene.root.Body.Body:setVisible(not state)
    models.aduene.root.Head:setVisible(not state)
    models.aduene.root.LeftLeg:setVisible(not state)
    models.aduene.root.RightLeg:setVisible(not state)
    
    if state then
        models.aduene.root.Body.Mantle:setOpacity(0.5)
        models.aduene.root.LeftArm.mantleLeft:setOpacity(0.5)
        models.aduene.root.RightArm.mantleRight:setOpacity(0.5)
        models.aduene.root.Body.Mantle:setPrimaryRenderType("EMISSIVE")
        models.aduene.root.LeftArm.mantleLeft:setPrimaryRenderType("EMISSIVE")
        models.aduene.root.RightArm.mantleRight:setPrimaryRenderType("EMISSIVE")

        models.aduene.root.Elytra.LeftElytra:setOpacity(0.5)
        models.aduene.root.Elytra.RightElytra:setOpacity(0.5)
        models.aduene.root.Elytra.LeftElytra:setPrimaryRenderType("EMISSIVE")
        models.aduene.root.Elytra.RightElytra:setPrimaryRenderType("EMISSIVE")
        
    else
        models.aduene.root.Body.Mantle:setOpacity(1)
        models.aduene.root.LeftArm.mantleLeft:setOpacity(1)
        models.aduene.root.RightArm.mantleRight:setOpacity(1)
    end
    models["starry-form"]:setVisible(state)
end

--pings.StarryForm(true)