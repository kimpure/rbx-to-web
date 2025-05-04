--//# TODO: MAKE TOKEN

local token = require('../dom/token')
local gui_object_dom = require('../dom/gui/object')
local gui_base2d_dom = require('../dom/gui/base2d')

local gui_base2d_layer = {}
gui_base2d_layer['UIAspectRatioConstraint'] = function(gui_object_layer: gui_object_dom.GuiObjectDom, ui_aspect_ratio_constraint: UIAspectRatioConstraint): (gui_base2d_dom.UIAspectRatioConstraintDom, number)
    local layer = gui_base2d_dom.from_ui_aspect_ratio_constraint(ui_aspect_ratio_constraint)
    for k, v in layer do
        (gui_object_layer :: any)[k] = v
    end
    return layer, token.ui_aspect_ratio_constraint
end

local function layer_gui_object(gui_object: GuiObject)
    local tokens = {}
    local gui_object_layer = gui_object_dom.from_gui_object(gui_object)
    
    for k, _ in gui_object_layer do
        tokens[k] = token.gui_object
    end

    for _, v in gui_object:GetChildren() do
        if not gui_base2d_layer[v.ClassName] then
            continue
        end
        local layer, token = gui_base2d_layer[v.ClassName](gui_object_layer, v)
        for k, _ in layer do
            tokens[k] = token
        end
    end

    return gui_object_layer, tokens
end

return {
    layer_gui_object = layer_gui_object,
}
