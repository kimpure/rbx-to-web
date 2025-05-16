local ui_aspect_ratio_constraint_dom = require('../../dom/ui_aspect_ratio_constraint')

local ui_aspect_ratio_constraint_css_parser: { [string]: (dom: ui_aspect_ratio_constraint_dom.UIAspectRatioConstraintDom) -> (any, number?) } = {}
ui_aspect_ratio_constraint_css_parser['aspect-ratio'] = function(dom)
    return nil, 2
end
ui_aspect_ratio_constraint_css_parser['height'] = function(dom)
    return nil, 2
end
ui_aspect_ratio_constraint_css_parser['width'] = function(dom)
    return nil, 2
end

return ui_aspect_ratio_constraint_css_parser
