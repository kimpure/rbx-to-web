local calc = require('./utils/calc')
local dom = require('../dom/dom')
local rgb = require('./utils/rgb')
local rgba = require('./utils/rgba')

local layer_parser = {}
layer_parser['background-color'] = function(dom: dom.Dom)
    return rgba.from_color(dom.background_color, 1 - dom.background_transparency)
end
layer_parser['box-shadow'] = function(dom: dom.Dom)
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
layer_parser['transform'] = function(dom: dom.Dom)
    return `rotate({dom.rotation}deg)`
end
layer_parser['position'] = function(dom: dom.Dom)
    return 'relative'
end
layer_parser['top'] = function(dom: dom.Dom)
    return calc.from_vec(dom.position.y)
end
layer_parser['left'] = function(dom: dom.Dom)
    return calc.from_vec(dom.position.x)
end
layer_parser['overflow'] = function(dom: dom.Dom)
    return dom.clips_descendants and 'hidden' or 'visible'
end
layer_parser['height'] = function(dom: dom.Dom)
    if dom.automatic_size == 'Y' or dom.automatic_size == 'XY' or dom.size_constraint == 'RelativeXX' then
        return 'auto'
    else
        return calc.from_vec(dom.size.y)
    end
end
layer_parser['width'] = function(dom: dom.Dom)
    if dom.automatic_size == 'X' or dom.automatic_size == 'XY' or dom.size_constraint == 'RelativeYY' then
        return 'auto'
    else
        return calc.from_vec(dom.size.x)
    end
end
layer_parser['min-height'] = function(dom: dom.Dom)
    if dom.size_constraint == 'RelativeXX' then
        return nil :: any
    end
    return calc.from_vec(dom.size.y)
end
layer_parser['min-width'] = function(dom: dom.Dom)
    if dom.size_constraint == 'RelativeYY' then
        return nil :: any
    end
    return calc.from_vec(dom.size.x)
end
layer_parser['aspect-ratio'] = function(dom: dom.Dom)
    if dom.size_constraint == 'RelativeXX' then
        return `{calc.from_vec(dom.size.x)} / {calc.from_vec(dom.size.y)}`
    end
    
    if dom.size_constraint == 'RelativeYY' then
        return `{calc.from_vec(dom.size.x)} / {calc.from_vec(dom.size.y)}`
    end

    return nil :: any
end
layer_parser['z-index'] = function(dom: dom.Dom)
    return dom.z_index
end

export type LayerProps = { [keyof<typeof(layer_parser)>]: string }

export type Layer = typeof(setmetatable({} :: LayerProps, {} :: {}))

local function from_dom(dom: dom.Dom): Layer
    local layer = setmetatable({}, {})

    for propname: keyof<typeof(layer_parser)>, callback in layer_parser :: any do
        (layer :: any)[propname] = callback(dom)
    end

    return layer
end

return {
    from_dom = from_dom,
}
