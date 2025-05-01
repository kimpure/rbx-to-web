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

export type DomProps = {
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

export type Dom = typeof(setmetatable({} :: DomProps, {} :: any))

local format_parser = {}
format_parser['Active'] = function(dom: Dom, value: boolean)
    dom.active = value
end
format_parser['AnchorPoint'] = function(dom: Dom, value: Vector2)
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
format_parser['AutomaticSize'] = function(dom: Dom, value: Enum.AutomaticSize)
    dom.automatic_size = value.Name :: AutomaticSize
end
format_parser['BackgroundColor3'] = function(dom: Dom, value: Color3)
    dom.background_color = color.fromColor3(value)
end
format_parser['BackgroundTransparency'] = function(dom: Dom, value: number)
    dom.background_transparency = value
end
format_parser['BorderColor3'] = function(dom: Dom, value: Color3)
    dom.border_color = color.fromColor3(value)
end
format_parser['BorderMode'] = function(dom: Dom, value: Enum.BorderMode)
    dom.border_mode = value.Name :: BorderMode
end
format_parser['BorderSizePixel'] = function(dom: Dom, value: number)
    dom.border_size = value
end
format_parser['ClipsDescendants'] = function(dom: Dom, value: boolean)
    dom.clips_descendants = value
end
format_parser['Interactable'] = function(dom: Dom, value: boolean)
    dom.interactable = value
end
format_parser['LayoutOrder'] = function(dom: Dom, value: number)
    dom.layout_order = value
end
format_parser['Position'] = function(dom: Dom, value: UDim2)
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
format_parser['Rotation'] = function(dom: Dom, value: number)
    dom.rotation = value
end
format_parser['Size'] = function(dom: Dom, value: UDim2)
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
format_parser['SizeConstraint'] = function(dom: Dom, value: Enum.SizeConstraint)
    dom.size_constraint = value.Name :: SizeConstraint
end
format_parser['Visible'] = function(dom: Dom, value: boolean)
    dom.visible = value
end
format_parser['ZIndex'] = function(dom: Dom, value: number)
    dom.z_index = value
end

local function from_gui_object(gui_object: GuiObject)
    local dom = setmetatable({
        background_color = color.zero,
        border_color = color.zero,
        position = vec2.zero,
        size = vec2.zero,
    }, {}) :: Dom

    format_parser.Size(dom, gui_object.Size)
    
    for propname: keyof<typeof(format_parser)>, callback in format_parser :: any do
        callback(dom, (gui_object :: any)[propname])
    end

    return dom
end

return {
    from_gui_object = from_gui_object,
}
