--Created by Laniakea (just_laniakea)
-- Uses Figura chat events to replace instances of 
-- common shorthands for patterns (like minds, jesters)
-- with their inline pattern equivalents.

local aliases = {}
--basics
aliases["minds"]="<ne,qaq>"
aliases["compass"]="<e,aa>"
aliases["alidades"]="<e,wa>"
aliases["archers"]="<e,wqaawdd>"
aliases["architects"]="<e,weddwaa>"
aliases["scouts"]="<e,weaqa>"

aliases["intro"]="<w,qqq>"
aliases["retro"]="<e,eee>"
aliases["consid"]="<w,qqqaw>"
aliases["hermes"]="<se,deaqq>"
aliases["reveal"]="<ne,de>"
--stack manip
aliases["jesters"]="<e,aawdd>"
aliases["gemini"]="<e,aadaadaa>"
aliases["gemini"]="<e,aadaa>"
--constants
aliases["+x"]="<nw,qqqqqea>"
aliases["+y"]="<nw,qqqqqew>"
aliases["+z"]="<nw,qqqqqed>"
aliases["-x"]="<sw,eeeeeqa>"
aliases["-y"]="<sw,eeeeeqw>"
aliases["-z"]="<sw,eeeeeqd>"
aliases["0vec"]="<nw,qqqqq>"
--lists
aliases["flocks disint"]="<nw,qwaeawq>"
aliases["flocks refl"]="<nw,qwaeawqaeaqa>"
aliases["flocks gambit"]="<sw,ewdqdwe>"
--spells
aliases["break"]="<e,qaqqqqq>"
aliases["explode"]="<e,aawaawaa>"
aliases["conjure water"]="<se,aqawqadaq>"
aliases["conjure block"]="<e,qqa>"
--common numbers (preceded by \)
aliases["\\0"]="<se,aqaa>"
aliases["\\1"]="<se,aqaaw>"
aliases["\\2"]="<se,aqaawa>"
aliases["\\3"]="<se,aqaawaw>"
aliases["\\4"]="<se,aqaawaa>"
aliases["\\5"]="<se,aqaaq>"
aliases["\\6"]="<se,aqaaedw>"
aliases["\\7"]="<se,aqaawaq>"
aliases["\\8"]="<se,aqaawaqw>"
aliases["\\9"]="<se,aqaawaaq>"
aliases["\\10"]="<se,aqaae>"

function events.chat_send_message(message)
    for i,v in pairs(aliases) do
        --eat spaces for phrases
        message = message:gsub(i.." ",v)        
        message = message:gsub(i,v)
    end
    return message
end