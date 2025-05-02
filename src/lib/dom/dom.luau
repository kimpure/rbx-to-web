
local gui_object_parser = require('./parser/gui_object')

export type GuiObjectDom = gui_object_parser.GuiObjectDom

local function from_gui_object(gui_object: GuiObject)
    local dom = setmetatable({}, {}) :: GuiObjectDom
    
    for propname, callback in gui_object_parser :: { [keyof<typeof(gui_object_parser)>]: any } do
        callback(dom, (gui_object :: any)[propname])
    end

    return dom
end

return {
    from_gui_object = from_gui_object,
}
