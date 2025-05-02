local vec2 = require('./utils/vec2')
local color = require('./utils/color')

export type AutomaticSize = "None" 
    | "X" 
    | "Y" 
    | "XY"

export type BorderMode = "Outline"
    | "Middle"
    | "Inset"

export type SizeConstraint = "RelativeXY"
    | "RelativeXX"
    | "RelativeYY"

export type GuiObjectDomProps = {
    active: boolean,
    automatic_size: AutomaticSize,
    background_color: color.Color,
    background_transparency: number,
    border_color: color.Color,
    border_mode: BorderMode,
    border_size: number,
    clips_descendants: boolean,
    interactable: boolean,
    layout_order: number,
    position: vec2.Vec2,
    rotation: number,
    size: vec2.Vec2,
    size_constraint: SizeConstraint,
    visible: boolean,
    z_index: number,
}

export type GuiObjectDom = typeof(setmetatable({} :: GuiObjectDomProps, {} :: any))

local gui_object_parser = {}
gui_object_parser['Active'] = function(dom: GuiObjectDom, value: boolean)
    dom.active = value
end
gui_object_parser['AnchorPoint'] = function(dom: GuiObjectDom, value: Vector2)
    dom.position = {
        x = {
            offset = dom.position.x.offset - dom.size.x.offset * value.X,
            scale = dom.position.x.scale - dom.size.x.scale * value.X,
        },
        y = {
            offset = dom.position.y.offset - dom.size.y.offset * value.Y,
            scale = dom.position.y.scale - dom.size.y.scale * value.Y            
        },
    }
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
    dom.position = {
        x = {
            offset = dom.position.x.offset + value.X.Offset,
            scale = dom.position.x.scale + value.X.Scale,
        },
        y = {
            offset = dom.position.y.offset + value.Y.Offset,
            scale = dom.position.y.scale + value.Y.Scale,
        },
    }
end
gui_object_parser['Rotation'] = function(dom: GuiObjectDom, value: number)
    dom.rotation = value
end
gui_object_parser['Size'] = function(dom: GuiObjectDom, value: UDim2)
    dom.size = {
        x = {
            offset = value.X.Offset,
            scale = value.X.Scale
        },
        y = {
            offset = value.Y.Offset,
            scale = value.Y.Scale
        }
    }
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

local function from_gui_object(gui_object: GuiObject)
    local dom = setmetatable({
        background_color = color.zero,
        border_color = color.zero,
        position = vec2.zero,
        size = vec2.zero,
    }, {}) :: GuiObjectDom

    gui_object_parser.Size(dom, gui_object.Size)
    
    for propname: keyof<typeof(gui_object_parser)>, callback in gui_object_parser :: any do
        callback(dom, (gui_object :: any)[propname])
    end

    return dom
end

return {
    from_gui_object = from_gui_object,
}
