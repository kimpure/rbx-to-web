local calc = require("../utils/calc")
local ui_corner_dom = require("../../dom/ui_corner")

local ui_corner = {}
ui_corner["border-radius"] = function(dom: ui_corner_dom.UICornerDom)
	return calc.from_ui(dom.corner_radius)
end

return ui_corner :: { [string]: (dom: ui_corner_dom.UICornerDom) -> string }
