local color = require("../../../dom/utils/color")

return {
	from_color = function(color: color.Color, transparency: number)
		return `rgba({color.r}, {color.g}, {color.b}, {transparency})`
	end,
}
