local path_str = require('@lune/process').os == 'windows' and '\\' or '/'

local gui_object_rbxm = require('@lune/fs').readFile(`tests{path_str}ui_corner{path_str}ui_corner.rbxm`)

local gui_object_instance = require('@lune/roblox').deserializeModel(gui_object_rbxm)[1] :: GuiObject

local css_lib = require('../../src/lib/css/css')

local css = css_lib.new()
css:with_gui_object(gui_object_instance)
css:with_ui_corner(gui_object_instance:FindFirstChildOfClass('UICorner') :: UICorner)

print(css:get_css())
