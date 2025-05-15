local gui_object_dom = require("../dom/gui_object")
local gui_object_css_parser = require("./css_parser/gui_object")
local ui_corner_dom = require("../dom/ui_corner")
local ui_corner_css_parser = require("./css_parser/ui_corner")

local extends = require('./css_parser/extends')
local token = require('./css_parser/token')

export type Style = typeof(setmetatable(
	{} :: {
		doms: {
			gui_object: {
				dom: gui_object_dom.GuiObjectDom,
				css_parser: typeof(gui_object_css_parser),
			}?,
			ui_corner: {
				dom: ui_corner_dom.UICornerDom,
				css_parser: typeof(ui_corner_css_parser),
			}?,
		},
		class: string,
	},
	{} :: StyleImpl
))

export type StyleImpl = {
	__index: StyleImpl,
	new: () -> Style,
	get_css: (self: Style) -> string,
	with_gui_object: (self: Style, gui_object: GuiObject) -> Style,
	with_ui_corner: (self: Style, ui_corner: UICorner) -> Style,
}

local gui_object_css = {} :: StyleImpl
gui_object_css.__index = gui_object_css

function gui_object_css.new()
	local self = setmetatable({ }, gui_object_css)
	self.doms = {}
	self.class = tostring(self)
	return self
end

function gui_object_css.with_gui_object(self, gui_object)
	self.doms[token.gui_object] = {
		dom = gui_object_dom.from_gui_object(gui_object),
		css_parser = gui_object_css_parser,
	}
	return self
end

function gui_object_css.with_ui_corner(self, ui_corner)
	self.doms[token.ui_corner] = {
		dom = ui_corner_dom.from_ui_corner(ui_corner),
		css_parser = ui_corner_css_parser,
	}
	return self
end

function gui_object_css.get_css(self)
	local css = ''
	local parse_css = {}
	local levels = {}

	for dom_name, dom_info in (self.doms :: any) :: { [string]: { dom: { [string]: any }, css_parser: { [string]: (...any) -> (string, number) } } } do
		local props = {}

		for extend_dom_name, _ in extends[dom_name] do
			if not self.doms[extend_dom_name] then
				return error(`extend error: faild {extend_dom_name}`)
			end
			props[extend_dom_name] = self.doms[extend_dom_name].dom
		end
		
		for css_prop_name, css_format_callback in dom_info.css_parser do
			local css_value, level = css_format_callback(props)
			level = level or 1

			if not levels[css_prop_name] then
				levels[css_prop_name] = level
			end

			if levels[css_prop_name] > level then
				continue
			end

			if not css_value then
				continue
			end

			parse_css[css_prop_name] = css_value
		end
	end
	
	for css_prop_name, css_prop_value in parse_css do
		css ..= `{css_prop_name}: {css_prop_value};\n`
	end

	return css
end

return gui_object_css
