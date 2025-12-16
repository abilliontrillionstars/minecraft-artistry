
Spells = {}

Spells["chorus"] = {
    -- blink forward 8 * potency+1 blocks.
    -- added size has no effect
    name="Chorus Blink",
    emoji=":mcb_chorus_flower:",
    anim="castWarp",
    modelparts={}
}
Spells["oxeye_daisy"] = {
    -- adds potency+2 extra ticks to a block or entity.
    -- lasts for 200 * size+1 ticks
    name="Accelerate",
    emoji=":mcb_oxeye:",
    anim="castOnBlock",
    modelparts={}
}
Spells["apple"] = {
    -- cure the caster of all effects.
    -- for any negative effect cured:
        -- slowness -> speed
        -- mining fatigue -> haste
        -- poison/wither -> regen
        -- blindness/confusion? -> night vision
        -- hunger -> saturation
        -- weakness -> strength
    -- with a level = original + potency
    -- added size has no effect
    name="Nature's Cure",
    emoji=":mcb_apple:",
    anim="castRaiseStaff",
    modelparts={}
}
Spells["lilac"] = {
    -- grows a *single block* via bonemeal at a chance.
    -- also advances nether wart stages at the same chance.
    -- chance is complicated! "if math.random(5 - potency) < 2)"  
        -- at 0 potency, 2 in 5 = 40%
        -- at 1 potency, 2 in 4 = 50%
        -- at 2 potency, 2 in 3 = 67%
        -- at 3 potency, 2 in 2 = 100%
    -- added size increases the *reach*.
    name="Growth",
    emoji=":mcb_lilac:",
    anim="castOnBlock",
    modelparts={}
}
Spells["peony"] = {
    -- heals the caster for 2*potency.
    -- seems to additionally heal for every two nearby flowers?
    -- added size has no effect
    name="Regeneration",
    emoji=":mcb_peony:",
    anim="castRaiseStaff",
    modelparts={}
}
Spells["white_tulip"] = {
    -- deals 5 + potency*3 damage to surrounding mobs.
    -- also slows them for 100 * potency+2 ticks at level potency.
    -- added size increases range (radius) around cast point
    name="Blistering Cold",
    emoji=":mcb_white_tulip:",
    anim="castRaiseStaff",
    modelparts={}
}
Spells["orange_tulip"] = {
    -- pushes out mobs and projectiles in a 2 + size/2 radius.
    -- push (in blocks/tick) is equal to 0.05 * potency+1
    name="Shielding",
    emoji=":mcb_orange_tulip:",
    anim="castRaiseStaff",
    modelparts={}
}
Spells["dandelion"] = {
    -- pushes out mobs and projectiles in a 2 + size/2 radius.
    -- push (in blocks/tick) is equal to 0.05 * potency+1
    name="Dandelion Winds",
    emoji=":mcb_orange_tulip:",
    anim="castOnBlock",
    modelparts={}
}
Spells["poisonous_potato"] = {
    -- calls lightning to the raycasted block.
    -- added size increases the *reach*.
    name="Electric Spark",
    emoji=":mci_poisonous_potato:",
    anim="castOnBlock",
    modelparts={}
}
