local token = require('./token')

local gui_object = token.gui_object
local ui_aspect_ratio_constraint = token.ui_aspect_ratio_constraint
local ui_corner = token.ui_corner

return {
    [gui_object] = {
        [gui_object] = true
    },
    [ui_aspect_ratio_constraint] = {
        [gui_object] = true,
        [ui_aspect_ratio_constraint] = true,
    },
    [ui_corner] = {
        [gui_object] = true,
        [ui_corner] = true,
    },
}
