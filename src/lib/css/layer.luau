local gui_object_dom = require('../dom/gui_object')
local ui_aspect_ratio_constraint_dom = require('../dom/ui_aspect_ratio_constraint')

local ui_layer = {}
ui_layer['UIAspectRatioConstraint'] = function(gui_object_layer: gui_object_dom.GuiObjectDom, ui_aspect_ratio_constraint: UIAspectRatioConstraint)
    local layer = ui_aspect_ratio_constraint_dom.from_ui_aspect_ratio_constraint(ui_aspect_ratio_constraint)
    for k, v in (layer :: any) :: ui_aspect_ratio_constraint_dom.UIAspectRatioConstraintDomProps do
        (gui_object_layer :: any)[k] = v
    end
end

local function layer(gui_object: GuiObject)
    local gui_object_layer = gui_object_dom.from_gui_object(gui_object)
    
    for _, v in gui_object:GetChildren() do
        if not ui_layer[v.ClassName] then
            continue
        end
        ui_layer[v.ClassName](gui_object_layer, v)
    end

    return gui_object_layer
end

return {
    layer = layer,
}
