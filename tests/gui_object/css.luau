local path_str = require('@lune/process').os == 'windows' and '\\' or '/'

local gui_object_rbxm = require('@lune/fs').readFile(`tests{path_str}gui_object{path_str}gui_object.rbxm`)

local gui_object_instance = require('@lune/roblox').deserializeModel(gui_object_rbxm)[1] :: GuiObject

local style_lib = require('../../src/lib/style/style')

local style = style_lib.new()
style:with_gui_object(gui_object_instance)

print(style:get_css())
