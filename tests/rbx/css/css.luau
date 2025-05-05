local dom = require('../../rbx/dom/dom')
local css = require('../../../src/lib/css/css')

return function(use_debug: boolean?): string
    if use_debug then
        print(css.from_gui_object(dom))
    end

    return css.from_gui_object(dom) :: string
end
