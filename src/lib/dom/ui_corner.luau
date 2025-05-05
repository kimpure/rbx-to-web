local ui = require('./utils/ui')

export type UICornerDomProps = {
    corner_radius: ui.Ui,
}

export type UICornerDom = typeof(setmetatable({} :: UICornerDomProps, {}))

local ui_corner_parser = {}
ui_corner_parser['CornerRadius'] = function(dom: UICornerDom, value: UDim)
    dom.corner_radius = ui.from_udim(value)
end

local function from_ui_corner(ui_corner: UICorner): UICornerDom
    local dom = setmetatable({}, {}) :: UICornerDom

    for propname, callback in ui_corner_parser :: { [string]: (dom: UICornerDom, value: any) -> () } do
        callback(dom, (ui_corner :: any)[propname])
    end
    
    return dom
end

return {
    from_ui_corner = from_ui_corner,
}
