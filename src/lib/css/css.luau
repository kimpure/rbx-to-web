local gui_object_dom = require('../dom/gui_object')
local gui_object_parser = require('./parser/gui_object')
local ui_corner_dom = require('../dom/ui_corner')
local ui_corner_parser = require('./parser/ui_corner')

local function from_gui_object(gui_object: GuiObject): string
    local css = ''

    local dom =  gui_object_dom.from_gui_object(gui_object)

    for k, v in gui_object_parser do
        css ..= `{k}: {v(dom)};\n`
    end

    return css
end

local function from_ui_corner(ui_corner: UICorner): string
    local css = ''

    local dom =  ui_corner_dom.from_ui_corner(ui_corner)

    for k, v in ui_corner_parser do
        css ..= `{k}: {v(dom)};\n`
    end

    return css
end

return {
    from_gui_object = from_gui_object,
    from_ui_corner = from_ui_corner,
}
