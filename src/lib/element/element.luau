local css = require('../css/css')

export type Element = typeof(setmetatable({} :: {
    css: css.Css,
    childs: { [number]: Element },
    parent: Element?
}, {} :: ElementImpl))

export type ElementImpl = {
    __index: ElementImpl,
    new: () -> Element,
    get_html: (self: Element) -> string,
    get_css: (self: Element) -> string,
    add_child: (self: Element, child: Element) -> (),
}

local function format_class(class: any): string
    return `luau_{string.gsub(string.gsub(tostring(class), ' ', ''), ':', '')}`
end

local element = {} :: ElementImpl
element.__index = element

function element.new()
    return setmetatable({
        css = css.new(),
        childs = {},
    }, element)
end

function element.add_child(self, child)
    child.parent = self
    self.childs[#self.childs + 1] = child
end

function element.get_html(self)
    local source = `<div class="{format_class(self)}">`

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
        source ..= `.{format_class(parents[#parents - i + 1])} > `
    end

    source ..= `.{format_class(self)} \{\n` .. self.css:get_css() .. '}'

    for _, child in self.childs do
        source ..= '\n' .. child:get_css()
    end

    return source
end

return element
