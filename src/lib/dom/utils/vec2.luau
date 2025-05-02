local types = require('../types')

export type Vec2 = types.Vec2

local Vec2 = {}

function Vec2.create(x: number, y: number): Vec2
    return { x = x, y = y }
end

return Vec2
