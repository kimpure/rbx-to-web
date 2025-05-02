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

function Ui2.from_udim2(udim2: UDim2): Ui2
    return {
        x = {
            offset = udim2.X.Offset,
            scale = udim2.X.Scale
        },
        y = {
            offset = udim2.Y.Offset,
            scale = udim2.Y.Scale
        }
    }
end

Ui2.zero = { x = { offset = 0, scale = 0 }, y = { offset = 0, scale = 0 } } :: Ui2

return Ui2
