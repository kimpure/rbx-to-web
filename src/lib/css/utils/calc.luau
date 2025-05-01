local vec2 = require('../../dom/utils/vec2')

local function from_vec(vec: typeof(vec2.zero.x))
    return `calc({vec.offset}px + {vec.scale * 100}%)`
end

return {
    from_vec = from_vec,
}
