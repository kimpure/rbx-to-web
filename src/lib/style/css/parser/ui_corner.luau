local calc = require("../utils/calc")
local ui = require('../../../dom/utils/ui')

local gui_object_dom = require('../../../dom/gui_object')
local ui_corner_dom = require("../../../dom/ui_corner")

local ui_corner: { 
	[string]: (doms: { gui_object: gui_object_dom.GuiObjectDom, ui_corner: ui_corner_dom.UICornerDom }) -> (string, number?) 
} = {}
ui_corner["border-radius"] = function(doms)
	local gui_object = doms.gui_object
	local ui_corner = doms.ui_corner
	
	local scale = math.min(gui_object.size.x.scale, gui_object.size.y.scale)
	local offset = ui_corner.corner_radius.offset

	local radius = ui.zero
	radius.offset = offset
	radius.scale = scale * ui_corner.corner_radius.scale

	return calc.from_ui(radius), 2
end

return ui_corner
