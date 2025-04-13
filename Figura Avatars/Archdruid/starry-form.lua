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
models["starry-form"].Head.HatLayer:setOpacity(0.75)

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
    models.aduene:setVisible(not state)
    models["starry-form"]:setVisible(state)
end

pings.StarryForm(true)