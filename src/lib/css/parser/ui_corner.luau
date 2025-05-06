local calc = require("../utils/calc")
local gui_object_dom = require('../../dom/gui_object')
local ui_corner_dom = require("../../dom/ui_corner")

local ui_corner = {}
ui_corner["border-radius"] = function(doms: { gui_object: gui_object_dom.GuiObjectDom, ui_corner: ui_corner_dom.UICornerDom })
	return calc.from_ui(doms.ui_corner.corner_radius)
end

return ui_corner :: { [string]: (dom: { gui_object: gui_object_dom.GuiObjectDom, ui_corner: ui_corner_dom.UICornerDom }) -> string }
