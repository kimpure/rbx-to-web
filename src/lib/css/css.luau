local layer = require('./layer')
local gui_object_parser = require('./parser/gui_object')

local function from_gui_object(gui_object: GuiObject): string
    local css = ''

    local gui_object_layer = layer.layer_gui_object(gui_object)

    for k, v in gui_object_parser do
        css ..= `{k}: {v(gui_object_layer)};\n`
    end

    return css
end

return {
    from_gui_object = from_gui_object,
}
