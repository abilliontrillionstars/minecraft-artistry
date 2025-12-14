--credit to ShadowCube264! ty for figuring this out for me!

-- Takes integers 0 to 255
function rootsColourFormat(r, g, b)
    local a = 255
    local val = a * 2 ^ 24 + r * 2 ^ 16 + g * 2 ^ 8 + b
    if val > 2 ^ 31 - 1 then
        val = val - 2 ^ 31
    end
    return val
end

-- Use the output of rootsColourFormat for the colour argument
function rootsParticleFormat(particleName, colour)
    return string.format("rootsclassic:%s{color:{color:%s}}", particleName, colour)
end
