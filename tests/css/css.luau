local instance = require("../rbx/instance")
local css_lib = require("../../src/lib/css/css")

local css = css_lib.new()
    :with_gui_object(instance.gui_object)
    :with_ui_corner(instance.ui_corner)

return css:get_css()
