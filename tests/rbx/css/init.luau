local layer = require('./layer/layer')
local css = require('../../../src/lib/css/css')

return function(use_debug: boolean?): string
    if use_debug then
        print(css.from_layer(layer))
    end

    return css.from_layer(layer) :: string
end
