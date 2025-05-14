local ui = require("../../../dom/utils/ui")

local function from_ui(ui: ui.Ui)
	return `calc({ui.offset}px + {ui.scale * 100}%)`
end

return {
	from_ui = from_ui,
}
