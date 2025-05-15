local ui_aspect_ratio_constraint_dom = require('../../dom/ui_aspect_ratio_constraint')

local ui_aspect_ratio_constraint_css_parser: { [string]: (dom: ui_aspect_ratio_constraint_dom.UIAspectRatioConstraintDom) -> (any, number?) } = {}
ui_aspect_ratio_constraint_css_parser['aspect-ratio'] = function(dom)
    return `{dom.aspect_ratio} / 1`, 2
end
ui_aspect_ratio_constraint_css_parser['height'] = function(dom)
    if dom.dominant_axis == 'Height' then
        return nil, -1
    end

    return nil
end
ui_aspect_ratio_constraint_css_parser['width'] = function(dom)
    if dom.dominant_axis == 'Width' then
        return nil, -1
    end

    return nil
end

return ui_aspect_ratio_constraint_css_parser
