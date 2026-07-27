-- handles animation playing while casting

--[[ 
notes:
    crouch to play the charge-up anim, release to cast
    figura reads the page number of a held spellbook (or a focus' name or other metadata in the hex)
    spell name denotes the anim to use
]]--

local animList = { -- list of overriden animations I want to make
    "idle", "walk", "walkback",
    "jumpup", "jumpdown",
    "walkjumpup", "walkjumpdown",
    "fall",
    "sprint",
    "sprintjumpup", "sprintjumpdown",
    "crouch", "crouchwalk", "crouchwalkback",
    "crouchjumpup", "crouchjumpdown",
    "trident",
    "sleep",
    "swim",
    "sit",
    "death"
}