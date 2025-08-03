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
aliases["+x "]="<nw,qqqqqea>"
aliases["+y "]="<nw,qqqqqew>"
aliases["+z "]="<nw,qqqqqed>"
aliases["-x "]="<sw,eeeeeqa>"
aliases["-y "]="<sw,eeeeeqw>"
aliases["-z "]="<sw,eeeeeqd>"
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
aliases["num0"]="<se,aqaa>"
aliases["num1"]="<se,aqaaw>"
aliases["num2"]="<se,aqaawa>"
aliases["num3"]="<se,aqaawaw>"
aliases["num4"]="<se,aqaawaa>"
aliases["num5"]="<se,aqaaq>"
aliases["num6"]="<se,aqaaedw>"
aliases["num7"]="<se,aqaawaq>"
aliases["num8"]="<se,aqaawaqw>"
aliases["num9"]="<se,aqaawaaq>"
aliases["num10"]="<se,aqaae>"
--arithmetic
aliases["add"]="<ne,waaw>"
aliases["subtract"]="<nw,wddw>"
aliases["multiply"]="<se,waqaw>"
aliases["mult"]="<se,waqaw>"
aliases["divide"]="<ne,wdedw>"
aliases["div"]="<ne,wdedw>"


function events.chat_send_message(message)
    for i,v in pairs(aliases) do   
        message = message:gsub(i,"<dark_green>"..v.."</>")
    end
    return message
end