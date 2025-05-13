local ui = require("./utils/ui")
local vec2 = require('./utils/vec2')

export type UICornerDomProps = {
	window_size: vec2.Vec2,
	corner_radius: ui.Ui,
}

export type UICornerDom = typeof(setmetatable({} :: UICornerDomProps, {}))

local ui_corner_dom_parser = {}
ui_corner_dom_parser["CornerRadius"] = function(dom: UICornerDom, value: UDim)
	dom.corner_radius = ui.from_udim(value)
end

local function from_ui_corner(ui_corner: UICorner, window_size: vec2.Vec2): UICornerDom
	local dom = setmetatable({
		window_size = window_size,
	}, {}) :: UICornerDom

	for propname, callback in ui_corner_dom_parser :: { [string]: (dom: UICornerDom, value: any) -> () } do
		callback(dom, (ui_corner :: any)[propname])
	end

	return dom
end

return {
	from_ui_corner = from_ui_corner,
}
