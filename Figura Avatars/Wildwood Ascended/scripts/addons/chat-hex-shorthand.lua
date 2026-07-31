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
aliases["reveal"]="<ne,de>"
--meta eval
aliases["intro"]="<w,qqq>"
aliases["retro"]="<e,eee>"
aliases["consid"]="<w,qqqaw>"
aliases["hermes"]="<se,deaqq>"
--stack manip
aliases["jesters"]="<e,aawdd>"
aliases["gemini"]="<e,aadaadaa>"
aliases["gemini"]="<e,aadaa>"
--constants
aliases["vec+x"]="<nw,qqqqqea>"
aliases["vec+y"]="<nw,qqqqqew>"
aliases["vec+z"]="<nw,qqqqqed>"
aliases["vec-x"]="<sw,eeeeeqa>"
aliases["vec-y"]="<sw,eeeeeqw>"
aliases["vec-z"]="<sw,eeeeeqd>"
aliases["0vec"]="<nw,qqqqq>"
--lists
aliases["flocks disint"]="<nw,qwaeawq>"
aliases["flocks refl"]="<nw,qwaeawqaeaqa>"
aliases["flocks gambit"]="<sw,ewdqdwe>"
--spells
aliases["break"]="<e,qaqqqqq>"
aliases["explode"]="<e,aawaawaa>"
aliases["conjure-water"]="<se,aqawqadaq>"
aliases["conjure-block"]="<e,qqa>"

aliases["read"]="<e,aqqqqq>"
aliases["write"]="<e,deeeee>"
--common numbers
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


--worldcasting
aliases["frag"]="<se,edeeeede>"
aliases["mass"]="<nw,waawaaw>"
aliases["com"]="<e,qaaqdee>"
aliases["project"]="<ne,eeeeewqqqqq>"
--worldcasting spells
aliases["push"]="<ne,qwqqqeaw>"
aliases["fracture"]="<w,aqwqawedwd>"


function events.chat_send_message(message) 
    local output = {}
    for word in string.gmatch(message, "[^ ]+") do
        table.insert(output, aliases[word] or word)
    end
    return table.concat(output, " ")

end


