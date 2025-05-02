local ui2 = require('../../dom/utils/ui2')

local function from_vec(vec: typeof(ui2.zero.x))
    return `calc({vec.offset}px + {vec.scale * 100}%)`
end

return {
    from_vec = from_vec,
}
