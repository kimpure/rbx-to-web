export type Color = {
    r: number,
    g: number,
    b: number,
}

local Color = {}

function Color.fromColor3(color3: Color3): Color
    return {
        r = 255 * color3.R,
        g = 255 * color3.G,
        b = 255 * color3.B,
    }
end

Color.zero = { r = 0, g = 0, b = 0 }

return Color
