local element = require('./lib/element')
local javascript = require('./lib/javascript')

local render = {}
render.javascriptSource = ''

render.addElement = {}
render.addElement.guiObject = function(guiObject: GuiObject)
    local guiObjectElement = element.guiObject.create(guiObject)
    local guiObjectClass = javascript.class.create('guiObject', guiObjectElement):method('apply')
    render.javascriptSource ..= guiObjectClass:getSource()
end

return render
