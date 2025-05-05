local calc = require('../utils/calc')
local ui_corner_dom = require('../../dom/ui_corner')
local rgb = require('../utils/rgb')
local rgba = require('../utils/rgba')

local ui_corner = {}
ui_corner['CornerRadius'] = function(dom: ui_corner_dom.UICornerDom)
    return calc.from_ui(dom.corner_radius)
end

return ui_corner
