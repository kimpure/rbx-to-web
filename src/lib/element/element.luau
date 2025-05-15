local style = require('../style/style')
local format_class_name = require('./utils/format_class_name')

export type Element = typeof(setmetatable({} :: {
    style: style.Style,
    childs: { [number]: Element },
    parent: Element?
}, {} :: ElementImpl))

export type ElementImpl = {
    __index: ElementImpl,
    new: () -> Element,
    get_html: (self: Element) -> string,
    get_css: (self: Element) -> string,
    get_style_js: (self: Element) -> string,
    add_child: (self: Element, child: Element) -> (),
}
local element = {} :: ElementImpl
element.__index = element

function element.new()
    return setmetatable({
        style = style.new(),
        childs = {},
    }, element)
end

function element.add_child(self, child)
    child.parent = self
    self.childs[#self.childs + 1] = child
end

function element.get_html(self)
    local source = `<div class="{format_class_name(self.style.class)}">`

    for _, child in self.childs do
        source ..= child:get_html()
    end
    
    source ..= '</div>'

    return source
end

function element.get_css(self)
    local source = ''

    local parents = {}
    local cureent_parent = self

    while true do
        if not cureent_parent.parent then
            break
        end
        cureent_parent = cureent_parent.parent
        parents[#parents + 1] = cureent_parent
    end

    for i=1, #parents do
        source ..= `.{format_class_name(parents[#parents - i + 1].style.class)} > `
    end

    source ..= `.{format_class_name(self.style.class)} \{\n` .. self.style:get_css() .. '}'

    for _, child in self.childs do
        source ..= '\n' .. child:get_css()
    end

    return source
end

function element.get_style_js(self)
    local function loop_main(el: Element)
        local s = el.style:get_style_js() .. '\n'
        for _, child in el.childs do
            s ..= loop_main(child)
        end
        return s
    end

    return loop_main(self)
end

return element
