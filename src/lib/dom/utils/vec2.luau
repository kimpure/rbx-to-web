export type Vec2 = {
    x: {
        offset: number,
        scale: number,
    },
    y: {
        offset: number,
        scale: number,
    },
}

local Vec2 = {}

Vec2.zero = { x = { offset = 0, scale = 0 }, y = { offset = 0, scale = 0 } } :: Vec2

return Vec2
