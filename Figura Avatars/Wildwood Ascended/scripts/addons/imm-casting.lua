
--muliplier for the bounds of the arm waving
ANGLEMOD = 1
--whether or not to additionally tilt the casting item, for ping rate budgeting
DOTILTSTAFF = true

--replace these with the arms and/or item pivots
RIGHTARMPATH = models.aduene.root.Body.RightArm
LEFTARMPATH = models.aduene.root.Body.LeftArm
RIGHTITEMPATH = models.aduene.root.Body.RightArm.RightItemPivot
LEFTITEMPATH = models.aduene.root.Body.LeftArm.LeftItemPivot

assert(RIGHTARMPATH and LEFTARMPATH,
    "\ncould not find arms or item pivots! make sure to replace the paths at the start of the file.\n")
assert(DOTILTSTAFF or (RIGHTITEMPATH and LEFTITEMPATH), 
    "\nthe item tilting mechanic is enabled, but could not find item pivots! make sure to replace the paths at the start of the file.")
    
local castingArm = RIGHTARMPATH
local mousePos
local oldMousePos
local isCasting

function pings.waveArm(x, y)
    --host:setActionbar(x..", "..y)
    --castingArm:setParentType("None")
    castingArm:setRot(x,y,0)
    if not isCasting and DOTILTSTAFF then 
        castingArm:getChildren()[3]:setRot()
    end
end
function pings.tiltStaff(toggle)
    if toggle then
        if castingArm==RIGHTARMPATH then RIGHTITEMPATH:setRot(-50,0,0)
        else LEFTITEMPATH:setRot(-50,0,0) end
    else
        if castingArm==RIGHTARMPATH then RIGHTITEMPATH:setRot(-45,0,0)
        else LEFTITEMPATH:setRot(-45,0,0) end
    end
end


function events.tick()
    if host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting" then
        isCasting = true
        if player:isLoaded() then 
            if player:getHeldItem(player:isLeftHanded()).id:find("staff") or player:getHeldItem(player:isLeftHanded()).id == "hexgloop:casting_ring" then
                castingArm = RIGHTARMPATH
            else
                castingArm = LEFTARMPATH
            end
            --sneakily add to the anglemod if we're holding a ring
            if player:getHeldItem(player:isLeftHanded()).id == "hexgloop:casting_ring" then ANGLEMOD = 1.2 end
        end
        --grab the mouse position
        mousePos = client:getMousePos()
        --set it relative to the center of the screen
        winDims = client:getWindowSize()
        mousePos = vec(mousePos[1]-(winDims[1]/2),mousePos[2]-(winDims[2]/2))
        --restrict the rotation to a certain angle
        --when did this get flipped? the world may never know. but it has to be this way because I can't find it
        mousePos = vec(mousePos[2]/-(winDims[1]/135), mousePos[1]/-(winDims[2]/60))
        --factor in ANGLEMOD
        mousePos = vec(mousePos[1]*ANGLEMOD, mousePos[2]*ANGLEMOD)
        --extend the arm out, just a tad
        mousePos[1] = mousePos[1] + 60
        --now, FLOOR IT! *epic chase scene*
        --this is for ping data rates, makes the numbers 2 bytes long
        mousePos = vec(math.floor(mousePos[1]), math.floor(mousePos[2]))
        
        --finally, rotate the arm accordingly
        if oldMousePos ~= mousePos then
            pings.waveArm(mousePos[1], mousePos[2])
        end
        --oh, and cache the old mouse position for mediating pings
        oldMousePos = mousePos
        
    else --grid closed
        if isCasting then --just once!
            isCasting = false
            pings.waveArm(0,0)
        end
    end
end

function events.mouse_press(button, action)
    --action: 0 for UP, 1 for DOWN
    if DOTILTSTAFF and host:getScreen() == "at.petrak.hexcasting.client.gui.GuiSpellcasting" then
        if action==1 then pings.tiltStaff(true)
        elseif action==0 then pings.tiltStaff(false)
        end
    end
end
