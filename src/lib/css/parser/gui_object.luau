local calc = require('../utils/calc')
local gui_object_dom = require('../../dom/gui/object')
local rgb = require('../utils/rgb')
local rgba = require('../utils/rgba')

local gui_object_css_parser = {}

gui_object_css_parser['background-color'] = function(dom: gui_object_dom.GuiObjectDom)
    return rgba.from_color(dom.background_color, 1 - dom.background_transparency)
end
gui_object_css_parser['box-shadow'] = function(dom: gui_object_dom.GuiObjectDom)
    return ({
        ['Inset'] = function(size: number, rgb: string)
            return `inset 0 0 0 {size}px {rgb}`
        end,
        ['Middle'] = function(size: number, rgb: string)
            return `0 0 0 {size / 2}px {rgb}, inset 0 0 0 {size / 2}px {rgb}`
        end,
        ['Outline'] = function(size: number, rgb: string)
            return `0 0 0 {size}px {rgb}`
        end
    })[dom.border_mode](
        dom.border_size,
        rgb.from_color(dom.border_color)
    )
end
gui_object_css_parser['transform'] = function(dom: gui_object_dom.GuiObjectDom)
    return `rotate({dom.rotation}deg) translate({dom.anchord_point.x * 100}%, {dom.anchord_point.y * 100}%)`
end
gui_object_css_parser['position'] = function(dom: gui_object_dom.GuiObjectDom)
    return 'relative'
end
gui_object_css_parser['top'] = function(dom: gui_object_dom.GuiObjectDom)
    return calc.from_vec(dom.position.y)
end
gui_object_css_parser['left'] = function(dom: gui_object_dom.GuiObjectDom)
    return calc.from_vec(dom.position.x)
end
gui_object_css_parser['overflow'] = function(dom: gui_object_dom.GuiObjectDom)
    return dom.clips_descendants and 'hidden' or 'visible'
end
gui_object_css_parser['height'] = function(dom: gui_object_dom.GuiObjectDom)
    if dom.automatic_size == 'Y' or dom.automatic_size == 'XY' or dom.size_constraint == 'RelativeXX' then
        return 'auto'
    else
        return calc.from_vec(dom.size.y)
    end
end
gui_object_css_parser['width'] = function(dom: gui_object_dom.GuiObjectDom)
    if dom.automatic_size == 'X' or dom.automatic_size == 'XY' or dom.size_constraint == 'RelativeYY' then
        return 'auto'
    else
        return calc.from_vec(dom.size.x)
    end
end
gui_object_css_parser['min-height'] = function(dom: gui_object_dom.GuiObjectDom)
    if dom.size_constraint == 'RelativeXX' then
        return nil :: any
    end
    return calc.from_vec(dom.size.y)
end
gui_object_css_parser['min-width'] = function(dom: gui_object_dom.GuiObjectDom)
    if dom.size_constraint == 'RelativeYY' then
        return nil :: any
    end
    return calc.from_vec(dom.size.x)
end
gui_object_css_parser['aspect-ratio'] = function(dom: gui_object_dom.GuiObjectDom)
    if dom.size_constraint == 'RelativeXX' then
        return `{calc.from_vec(dom.size.x)} / {calc.from_vec(dom.size.y)}`
    end
    
    if dom.size_constraint == 'RelativeYY' then
        return `{calc.from_vec(dom.size.x)} / {calc.from_vec(dom.size.y)}`
    end

    return nil :: any
end
gui_object_css_parser['z-index'] = function(dom: gui_object_dom.GuiObjectDom)
    return dom.z_index
end

return gui_object_css_parser :: { [keyof<typeof(gui_object_css_parser)> ]: (dom: gui_object_dom.GuiObjectDom) -> () }
