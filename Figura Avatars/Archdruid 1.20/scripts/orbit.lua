
OrbitPlanes = models.aduene.Orbits:getChildren()
-- ask about Confetti and how it makes particles on the fly
-- bc the hellpers told me you can't make new cubes at runtime
-- but then how does confetti work?? idk
-- (hi hellpers if you're reading this I mean no sass)


function makePlane(radius)
    local plane = models.aduene.root:newPart("plane")
    -- note: can't makle cubes at runtime. 
    -- will need to premake a bunch of really
    -- big planes and have this function draw to them
        -- using the distance from center and atan2 
        -- check that the original idea came from
    --print(plane)
end

for i,plane in pairs(OrbitPlanes) do  
    -- just call the set method for primtex
    -- beforehand and this will work
    --local _,tex = plane:getPrimaryTexture() 
    --local dims = tex:getDimensions()
    --tex:applyFunc(0, 0, dims[1], dims[2], test)
end


function test(x, y, width, height)
    -- check some distances
    -- to draw a circle

    -- check some trig
    -- to limit it to an arc
end