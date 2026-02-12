--[[Things I Want To Add To This Avatar
New Noises
New speed selection (maybe able to set a new max speed thru chat? or take status effects into account?)
Customizable forms for Watchband, Vinyl and Crone
Toggleable HUD that displays nearby entity names & health
Better looking @ people & entities
Fix bow draw
]]

--[[Things that have been improved
Better speed selection
Better flaps
Selecion Wheel
Randomized name function, commented out by default
Selection Wheel
Learned a LOT of trig
]]


--default hiding things
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

--Function to set a random name colour, line to call it has been commented out
function randomNameColor()
local moddedNameList = {}
local name = {"J","e","s","s"}
local colorList = {"FF000000", "FFFFFFFF", --[[end of palette]]"FF000000","FF000000",}
for i=1, #name do
    table.insert(moddedNameList,
    "{\"color\":\"" .. colorList[math.random(#colorList)] .."\"," .. 
    "\"text\":\"" .. name[i] .. "\"},")
end
return "[" .. string.sub(table.concat(moddedNameList),1,string.len(table.concat(moddedNameList))-1) .. "]"
end
--nameplate.All:setText(randomNameColor())

--keybinds
honk = keybinds:newKeybind("HONK!", "key.keyboard.h")

--variables
flaps = true --I'm not sure what I meant by this
drewBow = false
breathTime = 0
breathsLeft = 5
flappingToggle = true
AFKtimer = 0
AFKHeadRot = vec(0,0,0)
AFKDecider = 0
isBirdieAFK = false
plingToggle = true

--pings
function pings.playSoundAtBeak(soundFilePath) 
if player:isLoaded() then 
    sounds:playSound(soundFilePath, player:getPos()+vec(0,player:getEyeHeight(),0),1,(player:getLookDir().y *.2 + 1)) 
end
end
function pings.Animating(bool, animName)
animations.birb[animName]:setPlaying(bool)
end

--***
--Not quite variables, still needs to be declared
--***

--Action Wheel
MainPage = action_wheel:newPage()
action_wheel:setPage(MainPage)

--Chirps, cawws, and the like
aggressiveBirdNoises = { "aggroBirdNoise1", "aggroBirdNoise2" }
chirpingBirdNoises = { "chirp1", "chirp2" }
allBirdNoises = {
    "aggroBirdNoise1",
    "aggroBirdNoise2",
    "chirp1",
    "chirp2",
    "screm"
}


--Custom Controls
honk:setOnPress(function()
    --log(player:getNbt().SelectedItemSlot)
    if(player:getNbt().SelectedItemSlot == 0) then
        pings.playSoundAtBeak(aggressiveBirdNoises[math.random(#aggressiveBirdNoises)])
    elseif(player:getNbt().SelectedItemSlot == 1) then
        pings.playSoundAtBeak(chirpingBirdNoises[math.random(#chirpingBirdNoises)])
    else
        pings.playSoundAtBeak(allBirdNoises[math.random(#allBirdNoises)])
    end
end)



function events.tick()
    -- Speed Decider (just wanted to brag, this went from 23 lines to 14)
    --local walkingSpeeds = {"slowWalk","walk","fastWalk"}
    --if((player:getPose() == "STANDING" or player:getPose() == "CROUCHING")) then
    --    animations.birb["bigStretchy"]:setPlaying(false)
    --    for i=1, #walkingSpeeds do
    --        if(i==math.min(math.floor(player:getVelocity().xz:length()*8+1), 3)) then
    --            animations.birb[walkingSpeeds[i]]:setPlaying(true):setSpeed(player:getVelocity().xz:length()*4)
    --        else
    --            animations.birb[walkingSpeeds[i]]:setPlaying(false)
    --        end
    --    end
    --elseif(player:getPose() == "FALL_FLYING") then
    --    for i=1, #walkingSpeeds do
    --        animations.birb[walkingSpeeds[i]]:setPlaying(false)
    --        animations.birb["bigStretchy"]:setPlaying(true)
    --    end
    --end


    --Resets action wheel when closed
    if action_wheel:getCurrentPage() ~= MainPage and not action_wheel:isEnabled()then
        action_wheel:setPage(MainPage)
    end



    if(player:getVelocity() == vec(0,0,0)) then
        if(AFKDecider == 0) then
            AFKHeadRot = player:getLookDir()
            AFKDecider = 1
        else
            if(AFKHeadRot == player:getLookDir()) then
                AFKtimer = AFKtimer + 2
                AFKDecider = 0
                if(math.random(1,100) == 1 and AFKtimer > 80 and animations.birb.inquisitiveBirdy:isStopped() and animations.birb.beakToTheSky:isStopped() and animations.birb.preening:isStopped()) then
                pings.Animating(true, "inquisitiveBirdy")
                elseif(math.random(1,100) == 1 and AFKtimer > 80 and animations.birb.inquisitiveBirdy:isStopped() and animations.birb.beakToTheSky:isStopped() and animations.birb.preening:isStopped()) then
                pings.Animating(true, "beakToTheSky")
                elseif(math.random(1,100) == 1 and AFKtimer > 80 and animations.birb.inquisitiveBirdy:isStopped() and animations.birb.beakToTheSky:isStopped() and animations.birb.preening:isStopped()) then
                pings.Animating(true, "preening")
                end
            else
                AFKDecider = 0
                AFKtimer = 0
                isBirdieAFK = false
            end
        end
    else
        AFKtimer = 0
        AFKHeadRot = vec(0,0,0)
    end
    -- crouch fixing
    animations.birb.crouchHeadFix:setPlaying(player:getPose() == "CROUCHING")
end


local nick = {"lani", "pretty bird"}

function events.chat_receive_message(message, asJson) 
    if message:find("lua")
    then return asJson end

    if string.sub(message,1,1) == "<" then
    message = string.sub(message, message:find(">"), #message) end
    if string.sub(message,1,1) == "[" then
    message = string.sub(message, message:find("]"), #message) end

    message=string.lower(message)
    
    for nicks=1, #nick do
    if message:find(nick[nicks]) then
        pings.pling()
    end
end
end

function pings.pling()
    if plingToggle == true then
        range={(0.8*1.25), 0.8, 1.2}
        pitch=range[math.random(1,3)]
        if player:isLoaded() then
        sounds:playSound("block.note_block.flute", player:getPos(), 1, pitch*(1.1875))
        sounds:playSound("block.note_block.flute", player:getPos(), 1, pitch*(1.5625))
        sounds:playSound("block.note_block.flute", player:getPos(), 1, pitch*(1.5))
        sounds:playSound("block.note_block.flute", player:getPos(), 1, pitch*2)
        end
    end
end