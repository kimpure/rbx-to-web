local color = require("../../../dom/utils/color")

return {
	from_color = function(color: color.Color)
		return `rgb({color.r}, {color.g}, {color.b})`
	end,
}
