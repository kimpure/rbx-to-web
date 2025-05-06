local fs = require("@lune/fs")
local roblox = require("@lune/roblox")

local gui_object_path = "tests/rbx/assets/gui_object.rbxm"
local ui_corner_path = "tests/rbx/assets/ui_corner.rbxm"

local gui_object_instance = fs.readFile(gui_object_path)
local ui_corner = fs.readFile(ui_corner_path)

local gui_object = (roblox.deserializeModel(gui_object_instance)[1] :: any) :: GuiObject
local ui_corner = ((roblox.deserializeModel(ui_corner)[1] :: any) :: GuiObject):FindFirstChildOfClass(
		"UICorner"
	) :: UICorner

return {
	gui_object = gui_object,
	ui_corner = ui_corner,
}
