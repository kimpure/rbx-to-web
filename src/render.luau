local element = require('./lib/element')
local javascript = require('./lib/javascript')

local render = {}
render.javascriptSource = ''

render.addElement = {}
render.addElement.guiObject = function(guiObject: GuiObject)
    local guiObjectElement = element.guiObject.create(guiObject)
    local guiObjectClass = javascript.Class.create('guiObject', guiObjectElement):method('apply')
    render.javascriptSource ..= guiObjectClass:getSource()
end

local function _test()
    local fs = require("@lune/fs")
    local roblox = require('@lune/roblox')

    local example_instance = (roblox.deserializeModel(fs.readFile('examples/example.rbxm'))[1] :: any) :: GuiObject
    
    render.addElement.guiObject(example_instance)
end

return render
