local layer = require('./layer')

local function from_layer(layer: layer.Layer)
    local css = ''

    for k, v in layer do
        css ..= `{k}: {v};\n`
    end

    return css
end

return {
    from_layer = from_layer,
}
