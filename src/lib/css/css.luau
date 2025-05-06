local gui_object_dom = require('../dom/gui_object')
local gui_object_parser = require('./parser/gui_object')
local ui_corner_dom = require('../dom/ui_corner')
local ui_corner_parser = require('./parser/ui_corner')

local function parser_css(dom: any)
    local css = ''
    
    for k, v in gui_object_parser do
        if not v(dom) then
            continue
        end
        css ..= `{k}: {v(dom)};\n`
    end

    return css
end

local function from_gui_object(gui_object: GuiObject): string
    local dom =  gui_object_dom.from_gui_object(gui_object)

    return parser_css(dom)
end

local function from_ui_corner(ui_corner: UICorner): string
    local dom =  ui_corner_dom.from_ui_corner(ui_corner)

    return parser_css(dom)
end

return {
    from_gui_object = from_gui_object,
    from_ui_corner = from_ui_corner,
}
