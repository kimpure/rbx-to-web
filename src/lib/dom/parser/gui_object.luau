local types = require('../types')

export type AutomaticSize = types.AutomaticSize
export type BorderMode = types.BorderMode
export type GuiObjectDom = types.GuiObjectDom
export type SizeConstraint = types.SizeConstraint

local color = require('../utils/color')
local ui2 = require('../utils/ui2')
local vec2 = require('../utils/vec2')

local gui_object_parser = {}
gui_object_parser['Active'] = function(dom: GuiObjectDom, value: boolean)
    dom.active = value
end
gui_object_parser['AnchorPoint'] = function(dom: GuiObjectDom, value: Vector2)
    dom.anchord_point = vec2.create(value.X, value.Y)
end
gui_object_parser['AutomaticSize'] = function(dom: GuiObjectDom, value: Enum.AutomaticSize)
    dom.automatic_size = value.Name :: AutomaticSize
end
gui_object_parser['BackgroundColor3'] = function(dom: GuiObjectDom, value: Color3)
    dom.background_color = color.fromColor3(value)
end
gui_object_parser['BackgroundTransparency'] = function(dom: GuiObjectDom, value: number)
    dom.background_transparency = value
end
gui_object_parser['BorderColor3'] = function(dom: GuiObjectDom, value: Color3)
    dom.border_color = color.fromColor3(value)
end
gui_object_parser['BorderMode'] = function(dom: GuiObjectDom, value: Enum.BorderMode)
    dom.border_mode = value.Name :: BorderMode
end
gui_object_parser['BorderSizePixel'] = function(dom: GuiObjectDom, value: number)
    dom.border_size = value
end
gui_object_parser['ClipsDescendants'] = function(dom: GuiObjectDom, value: boolean)
    dom.clips_descendants = value
end
gui_object_parser['Interactable'] = function(dom: GuiObjectDom, value: boolean)
    dom.interactable = value
end
gui_object_parser['LayoutOrder'] = function(dom: GuiObjectDom, value: number)
    dom.layout_order = value
end
gui_object_parser['Position'] = function(dom: GuiObjectDom, value: UDim2)
    dom.position = ui2.from_udim2(value)
end
gui_object_parser['Rotation'] = function(dom: GuiObjectDom, value: number)
    dom.rotation = value
end
gui_object_parser['Size'] = function(dom: GuiObjectDom, value: UDim2)
    dom.size = ui2.from_udim2(value)
end
gui_object_parser['SizeConstraint'] = function(dom: GuiObjectDom, value: Enum.SizeConstraint)
    dom.size_constraint = value.Name :: SizeConstraint
end
gui_object_parser['Visible'] = function(dom: GuiObjectDom, value: boolean)
    dom.visible = value
end
gui_object_parser['ZIndex'] = function(dom: GuiObjectDom, value: number)
    dom.z_index = value
end

return gui_object_parser
