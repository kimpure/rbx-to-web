export type Ui2 = {
    x: {
        offset: number,
        scale: number,
    },
    y: {
        offset: number,
        scale: number,
    },
}

local Ui2 = {}

Ui2.zero = { x = { offset = 0, scale = 0 }, y = { offset = 0, scale = 0 } } :: Ui2

return Ui2
