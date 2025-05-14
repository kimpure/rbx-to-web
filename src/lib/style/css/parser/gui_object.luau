local calc = require("../utils/calc")
local gui_object_dom = require("../../../dom/gui_object")
local rgb = require("../utils/rgb")
local rgba = require("../utils/rgba")

local gui_object_css_parser: { 
	[string]: (doms: { gui_object: gui_object_dom.GuiObjectDom }) -> (any?, number?),
} = {}
gui_object_css_parser['aspect-ratio'] = function(doms)
	local dom = doms.gui_object
	return ({
		['RelativeXX'] = function()
			return `{dom.size.x.scale} / {dom.size.y.scale}`
		end,
		['RelativeXY'] = function()
			return
		end,
		['RelativeYY'] = function()
			return `{dom.size.y.scale} / {dom.size.x.scale}`
		end,
	})[dom.size_constraint]()
end
gui_object_css_parser["background-color"] = function(doms)
	local dom = doms.gui_object
	return rgba.from_color(dom.background_color, 1 - dom.background_transparency)
end
gui_object_css_parser["box-shadow"] = function(doms)
	local dom = doms.gui_object
	return ({
		["Inset"] = function(size: number, rgb: string)
			return `inset 0 0 0 {size}px {rgb}`
		end,
		["Middle"] = function(size: number, rgb: string)
			return `0 0 0 {size / 2}px {rgb}, inset 0 0 0 {size / 2}px {rgb}`
		end,
		["Outline"] = function(size: number, rgb: string)
			return `0 0 0 {size}px {rgb}`
		end,
	})[dom.border_mode](dom.border_size, rgb.from_color(dom.border_color))
end
gui_object_css_parser["transform"] = function(doms)
	local dom = doms.gui_object
	return `rotate({dom.rotation}deg) translate({dom.anchord_point.x * 100}%, {dom.anchord_point.y * 100}%)`
end
gui_object_css_parser["position"] = function(doms)
	return "relative"
end
gui_object_css_parser["top"] = function(doms)
	local dom = doms.gui_object
	return calc.from_ui(dom.position.y)
end
gui_object_css_parser["left"] = function(doms)
	local dom = doms.gui_object
	return calc.from_ui(dom.position.x)
end
gui_object_css_parser["overflow"] = function(doms)
	local dom = doms.gui_object
	return dom.clips_descendants and "hidden" or "visible"
end
gui_object_css_parser["height"] = function(doms)
	local dom = doms.gui_object
	if dom.size_constraint == 'RelativeXX' then
		return
	end
	return calc.from_ui(dom.size.y)
end
gui_object_css_parser["width"] = function(doms)
	local dom = doms.gui_object
	if dom.size_constraint == 'RelativeYY' then
		return
	end
	return calc.from_ui(dom.size.x)
end
gui_object_css_parser["z-index"] = function(doms)
	local dom = doms.gui_object
	return dom.z_index
end

return gui_object_css_parser
