local dom = require('../../rbx/dom/ui_corner')
local css = require('../../../src/lib/css/css')

return function(use_debug: boolean?): string
    if use_debug then
        print(css.from_ui_corner(dom:FindFirstChildOfClass('UICorner') :: UICorner))
    end

    return css.from_ui_corner(dom:FindFirstChildOfClass('UICorner') :: UICorner) :: string
end
