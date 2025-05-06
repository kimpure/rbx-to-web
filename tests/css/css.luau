local instance = require("../rbx/instance")
local css_lib = require("../../src/lib/css/css")

local gui_object_css = css_lib.from_gui_object(instance.gui_object)
local ui_corner_css = gui_object_css:with_ui_corner(instance.ui_corner)

return ui_corner_css:get_css()
