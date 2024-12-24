-- modeled after the Ring of Dexterous Motion from botania. --


function dodge(player, dir)
    if (player.getAbilities().flying or  not player.onGround() or dir == Direction.UP or dir == Direction.DOWN) then
        return
    end

    yaw = player.getYRot()
    x = math.sin(-yaw * 0.017453292 - math.PI)
    z = math.cos(-yaw * 0.017453292 - math.PI)
    if (dir == Direction.NORTH or dir == Direction.SOUTH) then
        x = math.cos(-yaw * 0.017453292)
        z = math.sin(yaw * 0.017453292)
    end
    local lookVec = vec(x, 0, z);
    --local sideVec = lookVec.cross(new Vec3(0, dir == Direction.WEST || dir == Direction.NORTH ? 1 : (dir == Direction.EAST || dir == Direction.SOUTH ? -1 : 0), 0)).scale(1.25);

    --player.setDeltaMovement(sideVec);

end
