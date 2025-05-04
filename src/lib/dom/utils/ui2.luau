local ui = require('./ui')

export type Ui2 = {
    x: ui.Ui,
    y: ui.Ui,
}

local Ui2 = {}

function Ui2.from_udim2(udim2: UDim2): Ui2
    return {
        x = ui.from_udim(udim2.X),
        y = ui.from_udim(udim2.Y),
    }
end

Ui2.zero = { x = ui.zero, y = ui.zero } :: Ui2

return Ui2
