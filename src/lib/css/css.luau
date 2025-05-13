local gui_object_dom = require("../dom/gui_object")
local gui_object_parser = require("./parser/gui_object")
local ui_corner_dom = require("../dom/ui_corner")
local ui_corner_parser = require("./parser/ui_corner")

local extends = require('./parser/extends')
local token = require('./parser/token')

local vec2 = require('../dom/utils/vec2')

export type Css = typeof(setmetatable(
	{} :: {
		window_size: vec2.Vec2,
		doms: {
			gui_object: {
				dom: gui_object_dom.GuiObjectDom,
				parser: typeof(gui_object_parser),
			}?,
			ui_corner: {
				dom: ui_corner_dom.UICornerDom,
				parser: typeof(ui_corner_parser),
			}?,
		},
	},
	{} :: CssImpl
))

export type CssImpl = {
	__index: CssImpl,
	new: (window_size: vec2.Vec2) -> Css,
	get_css: (self: Css) -> string,
	with_gui_object: (self: Css, gui_object: GuiObject) -> Css,
	with_ui_corner: (self: Css, ui_corner: UICorner) -> Css,
}

local gui_object_css = {} :: CssImpl
gui_object_css.__index = gui_object_css

function gui_object_css.new(window_size)
	return setmetatable({ 
		window_size = window_size,
		doms = {},
	}, gui_object_css) :: Css
end

function gui_object_css.with_gui_object(self, gui_object)
	self.doms[token.gui_object] = {
		dom = gui_object_dom.from_gui_object(gui_object),
		parser = gui_object_parser,
	}
	return self
end

function gui_object_css.with_ui_corner(self, ui_corner)
	self.doms[token.ui_corner] = {
		dom = ui_corner_dom.from_ui_corner(ui_corner, self.window_size),
		parser = ui_corner_parser,
	}
	return self
end

function gui_object_css.get_css(self)
	local css = ''
	local parse_css = {}
	local levels = {}

	for dom_name, dom_info in (self.doms :: any) :: { [string]: { dom: { [string]: any }, parser: { [string]: (...any) -> (string, number) } } } do
		local props = {}

		for extend_dom_name, _ in extends[dom_name] do
			if not self.doms[extend_dom_name] then
				return error(`extend error: faild {extend_dom_name}`)
			end
			props[extend_dom_name] = self.doms[extend_dom_name].dom
		end
		
		for css_prop_name, css_format_callback in dom_info.parser do
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
