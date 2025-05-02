export type Vec2 = { x: number, y: number }

local Vec2 = {}

function Vec2.create(x: number, y: number): Vec2
    return { x = x, y = y }
end

return Vec2
