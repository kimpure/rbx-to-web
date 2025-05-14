local net = require("@lune/net")
local fs = require("@lune/fs")
local roblox = require('@lune/roblox')

local example_instance = (roblox.deserializeModel(fs.readFile('examples/example.rbxm'))[1] :: any) :: GuiObject
local element_lib = require('../src/lib/element/element')

local element = element_lib.new()
element.style:with_gui_object(example_instance):with_ui_corner(example_instance:FindFirstChild('UICorner') :: UICorner)

local function t(obj: GuiObject, ell: element_lib.Element)
	local el = element_lib.new()
	el.style:with_gui_object(obj):with_ui_corner(obj:FindFirstChild('UICorner') :: UICorner)
	ell:add_child(el)
	if obj:FindFirstChildOfClass('Frame') then
		t(obj:FindFirstChildOfClass('Frame') :: Frame, el)
	end
end
t(example_instance:FindFirstChildOfClass('Frame') :: Frame, element)
t = nil :: any

fs.writeFile("examples/view/style.css", [[
html, body {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
}

]] .. element:get_css())

fs.writeFile("examples/view/index.html", string.format([[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    %s
	<script src="./style.js"></script>
</body>
</html>

]], element:get_html()))

net.serve(8080, {
	handleRequest = function(request)
		if request.path == "/style.css" then
			return {
				status = 200,
				headers = {
					["Content-Type"] = "text/css; charset=utf-8",
				},
				body = fs.readFile("examples/view/style.css"),
			}
		end

		if request.path == "/style.js" then
			return {
				status = 200,
				headers = {
					["Content-Type"] = "text/js; charset=utf-8",
				},
				body = fs.readFile("examples/view/style.js"),
			}
		end

		return {
			status = 200,
			headers = {
				["Content-Type"] = "text/html; charset=utf-8",
			},
			body = fs.readFile("examples/view/index.html"),
		}
	end,
})
