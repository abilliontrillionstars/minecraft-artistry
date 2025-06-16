-- cache the last arcana cast by action wheel to a table. each color has its own cache.
ArcanaCache = {
    -- MATTER
    cyan={
        right={message="brush-shift:multitool", anim="castArmsIn1"},
        middle={message="area:item:recharge:foo", anim="castArmsOut1"},
        left={message="", anim=""},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    light_blue={
        right={message="", anim=""},
        middle={message="cont:winter-wind:2", anim="castTwirlStaff1Start"},
        left={message="area:player:night-vision", anim="castInkCross1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    blue={
        right={message="", anim=""},
        middle={message="cont:forcefield:1", anim="castTwirlStaff1Start"},
        left={message="self-aegis", anim="castInkCross1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    lime={
        right={message="brush-shift:nature's staff", anim="castSpinRaiseWand"},
        middle={message="", anim=""},
        left={message="", anim=""},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    -- TIME
    magenta={
        right={message="brush-shift:bag of holding", anim="castArmsIn1"},
        middle={message="cont:accelerate:1", anim="castTwirlStaff1Start"},
        left={message="area:living:slow-time", anim="castStaffOrbit1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    pink={
        right={message="area:player:heal", anim="castArmsOut2"},
        middle={message="area:player:gate:wife", anim="castInkCircle1"},
        left={message="", anim=""},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    purple={
        right={message="brush-shift:colorful world", anim="castArmsIn1"},
        middle={message="area:player:gate:acad", anim="castInkCircle1"},
        left={message="firework-shot", anim="castSlingInk1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    red={
        right={message="brush-shift:estrogen pill", anim="castArmsIn1"},
        middle={message="area:monster:toss:foo", anim="castSlamStaff1"},
        left={message="area:monster:toss:foo", anim="castSlamStaff1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    -- ENERGY
    yellow={
        right={message="area:player:altiora", anim="castSpinRaiseWand"},
        middle={message="area:player:anchorite", anim="castInkCircle1"},
        left={message="zap", anim="castSlingInk1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="brush-shift:radiance staff", anim="castArmsIn1"},
    },
    brown={
        right={message="brush-shift:monkfruit,32", anim="castArmsIn1"},
        middle={message="area:player:gate:spawn", anim="castInkCircle1"},
        left={message="extinguish", anim="castSlingInk1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="conjure-water", anim="castInkCircle1"},
    },
    green={
        right={message="brush-shift:crafting tablet", anim="castArmsIn1"},
        middle={message="area:player:gate:home", anim="castInkCircle1"},
        left={message="area:player:cure", anim="castInkCross1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    orange={
        right={message="area:item:smelt:foo", anim="castInkCircle1"},
        middle={message="area:monster:ignite:foo", anim="castArmsOut1"},
        left={message="fire-shot", anim="castSlingInk1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    -- VOID
    black={
        right={message="area:player:gate:wheel", anim="castInkCircle1"},
        middle={message="", anim=""},
        left={message="", anim=""},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    gray={
        right={message="", anim=""},
        middle={message="area:item:mediafy:foo", anim="castSpinRaiseWand"},
        left={message="", anim=""},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    light_gray={
        right={message="wall-phase", anim="castInkCross1"},
        middle={message="summon-ae2", anim="castInkCircle1"},
        left={message="mine", anim="castSlingInk1"},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
    white={
        right={message="", anim=""},
        middle={message="", anim=""},
        left={message="", anim=""},
        forward={message="hexshot", anim="castSlingInk1"},
        back={message="", anim=""},
    },
}