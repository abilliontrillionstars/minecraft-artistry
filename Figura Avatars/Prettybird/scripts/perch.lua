
function events.tick()
    if not player:isLoaded() then return end
    
    --Perching on thin objects
    local perch = world.getBlockState(player:getPos() - vec(0,0.1,0))
    local perchCount = #perch:getCollisionShape()
    --logTable(perch:getCollisionShape())

    if(perch:getCollisionShape()[perchCount] ~= nil and player:getVelocity():length() == 0) then
        local perchsize = (perch:getCollisionShape()[perchCount][2] - perch:getCollisionShape()[perchCount][1])
        --log(perchsize)
        if((player:getBodyYaw() % 360 > 315 or player:getBodyYaw() % 360 < 45) and perchsize.z < 0.8) then
            --log("South")
            animations.birb.perch:play()
        elseif((player:getBodyYaw() % 360 > 225 and player:getBodyYaw() % 360 < 315) and perchsize.x < 0.8) then
            --log("West")
            animations.birb.perch:play()
        elseif((player:getBodyYaw() % 360 > 135 and player:getBodyYaw() % 360 < 225) and perchsize.z < 0.8) then
            --log("North")
            animations.birb.perch:play()
        elseif((player:getBodyYaw() % 360 > 45 and player:getBodyYaw() % 360 < 135) and perchsize.x < 0.8) then
            --log("East")
            animations.birb.perch:play()
        else
            animations.birb.perch:stop()
        end
    else
        animations.birb.perch:stop()
    end
end