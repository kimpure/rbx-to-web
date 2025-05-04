--//#TODO: https://create.roblox.com/docs/ko-kr/reference/engine/classes/UIDragDetector
local ui = require('../utils/ui')

export type DominantAxis = "Width" | "Height"

export type UIAspectRatioConstraintDomProps = {
    aspect_ratio: number,
    dominant_axis: DominantAxis,
}

export type UIAspectRatioConstraintDom = typeof(setmetatable({} :: UIAspectRatioConstraintDomProps, {}))

export type UICornerDomProps = {
    corner_radius: ui.Ui,
}

export type UICornerDom = typeof(setmetatable({} :: UICornerDomProps, {}))

local ui_aspect_ratio_constraint_parser = {}
ui_aspect_ratio_constraint_parser['AspectRatio'] = function(dom: UIAspectRatioConstraintDom, value: number)
    dom.aspect_ratio = value
end
ui_aspect_ratio_constraint_parser['AspectType'] = function(dom: UIAspectRatioConstraintDom, value: Enum.AspectType) end
ui_aspect_ratio_constraint_parser['DominantAxis'] = function(dom: UIAspectRatioConstraintDom, value: Enum.DominantAxis)
    dom.dominant_axis = value.Name :: DominantAxis
end

local ui_corner_parser = {}
ui_corner_parser['CornerRadius'] = function(dom: UICornerDom, value: UDim)
    dom.corner_radius = ui.from_udim(value)
end

local function from_ui_aspect_ratio_constraint(ui_aspect_ratio_constraint)
    local dom = setmetatable({}, {}) :: UIAspectRatioConstraintDom

    for propname, callback in ui_aspect_ratio_constraint_parser :: { [keyof<typeof(ui_aspect_ratio_constraint_parser)>]: (dom: UIAspectRatioConstraintDom, value: any) -> () } do
        callback(dom, (ui_aspect_ratio_constraint :: any)[propname])
    end
    
    return dom
end

local function from_ui_corner(ui_corner: UICorner)
    local dom = setmetatable({}, {}) :: UICornerDom

    for propname, callback in ui_corner_parser :: { [keyof<typeof(ui_corner_parser)>]: (dom: UICornerDom, value: any) -> () } do
        callback(dom, (ui_corner :: any)[propname])
    end
    
    return dom
end

return {
    from_ui_aspect_ratio_constraint = from_ui_aspect_ratio_constraint,
    from_ui_corner = from_ui_corner,
}
