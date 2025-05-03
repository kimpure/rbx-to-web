export type Vec2 = { 
    x: number, 
    y: number,
}

local Vec2 = {}

function Vec2.from_vector2(vector2: Vector2): Vec2
    return { x = vector2.X, y = vector2.Y }
end

return Vec2
