## build plans
### the observatory
  make a version of the mountain-based circle of stars megalithic site ("the observatory") in Wildwood's lore. this could be a great place to put my akashic library? it'd also be a great use of large-scale terrain manipulation hexes (more on that in the "making the observatory" section). the observatory will consist of a very large cavity underneath a mountain, with a small opening at the top of the peak for starlight to shine through. this large cavity will feature multiple vertical levels, sat on natural cliffs dug out into the cavity, near the edges of the spheroid. on these levels, build some small mossy stone huts, some ruined or without rooves (who needs 'em when you live in a mountain?). in the center of the cavity there will be a sizable raised platform decorated with an altar. surrounding this altar will be magical paraphernalia and some atmospheric effects from a figura skull. the akashic library will likely be here as well.
### the city of polaris
  I'm thinking also about making a city with roads in the shape of rings, like what was described to me in a lecture about polar coordinates. wide brick roads, ancient greek houses with quark shingled rooves (mostly reddish but also some with other colors) and diorite or other off-white walls. add some kind of plaza in the center mirroring the altar at the center of the observatory. maybe another druid of the circle of stars went on to build this village directly in the observatory's image (in lore this is frowned upon because the site is meant to be clandestine and free of outsiders, and this risks our secrets being leaked). 
## hex plans
### chatcasting
  similar to my Virtuoso, I think a hierarchical model with handlers/modules makes the most sense and makes it easiest for me to wrap my head around things. for example, it'd have a gate handler that takes `gate` and another argument that looks in the gate list for a gate by that second argument's name.
  some other hexes planned (inspired by Wildwood's D&D counterpart's abilities):
  - hidden step (give invis, is this possible in 1.21?)
  - guidance cantrip? (give situational buffs to a target or myself)
    - haste if they're holding a mining tool
    - strength if they're holding a weapon
    - night vision if they're in the dark
  - starry form in the three constellations, with a special manually cast hex (or emote keybind)
    - archer (activate while looking around), which throws spectral arrows semi-passively
    - chalice (activate while looking down), which can heal someone by crouching and looking at them (or myself)
    - dragon (activate while looking up), which gives flight and some TBD wisdom-based thing
  - hexes based on the D&D spell list. spells marked as needing concentration (C) similarly need my bound wisp
    - (1st) Guiding Bolt, which shoots a homing wisp (choosing a target based on who is closest to my reticle)
    - (1st) Earth Tremor, which creates a sizable explosion and slows targets in the area (spawn a wisp that slows every second in a range of the difficult terrain left)
    - (2nd) Augury, which has some TBD scrying thing
    - (2nd)(C) Gust of Wind, which creates a brief but constant wind (wisp conjured sneakily in the ground)
    - (2nd)(C) Hold Person, which applies slowness 5 and conjures blocks (alternatively conjuring leaves for the vine flavoring that I did late in the campaign)
    - (3rd)(C) Aura of Vitality, which gives light regen to anything near me (excluding monsters)
    - (3rd)(C) Wind Wall, which blocks projectiles
    - (3rd) Erupting Earth, which creates a large explosion and slows targets (like Earth Tremor, but larger, and creates sublevels)
    - (3rd) Tidal Wave, which conjures a wall of water, assembles it, and commands it to move in a straight line (might not be possible exactly like this)
    - (3rd)(C) Call Lightning, which puts me in a lightning-strike mode
    - (3rd) Revivify, which gates dead players to me (passively looks for players that drop to zero and marks them) 
    - (4th) Divination, which has a more powerful TBD scrying thing
    - (4th)(C) Watery Sphere, which conjures a sphere of water and assembles it, and summons a wisp to follow the center of it, pulling in anything in the water towards the center
    - (4th) Ice Storm, which conjures a rain of arrows (that figura makes look like ice spikes)
    - (5th)(C) Maelstrom, which creates a storm that 0.5-explodes things each second and pulls them towards the center of the storm
    - (5th) Tree Stride, which teleports me to anywhere that there's a tree (really just map teleport)
    - (5th)(C) Control Winds, which like Gust of Wind creates a constant wind, but it can be either up, down, or in a horizontal direction
    - (5th) Wall of Stone, which creates a sublevel of a stone-like block and tries to position it based on my look direction
    - (5th) Mass Healing Word, which heals all nearby creatures to full with casts of regen 6
    
### circle of terrain manipulation
  make a circlespam setup; ideally it'll be two headless (eight slates in a ring with a trapped media wave) loopers running a hermes quine, one staggered by a tick from the other. they would share ambit, and some data through a focus. for convenience, I'll make them clerics so that they don't have to walk to my position (this'd also be nice if I make this circle also execute my chatcasting).

### making the observatory
  to make the observatory, first make the circle of terrain manipulation, and then excavate a hemisphere with a large radius (make sure to record this part, it'll be epic) while keeping the ground below intact. then, excavate further into the walls to make the catwalk-like ridge that goes around the whole sphere.
