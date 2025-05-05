local gui_object_parser = require('./gui_object')
local ui_aspect_ratio_constraint = require('./ui_aspect_ratio_constraint')
local ui_corner = require('./ui_corner')

local function parser(parser_data: { [string]: (any) -> any }, ...: any): { [string]: string }
    local parse = {}
    for k, v in parser_data do
        parse[k] = v(...)
    end
    return parse
end

return {
    parser = parser,
    gui_object_parser = gui_object_parser,
    ui_aspect_ratio_constraint = ui_aspect_ratio_constraint,
    ui_corner = ui_corner,
}