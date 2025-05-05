local ui2 = require('../../dom/utils/ui2')

local function from_ui(ui: typeof(ui2.zero.x))
    return `calc({ui.offset}px + {ui.scale * 100}%)`
end

return {
    from_ui = from_ui,
}
