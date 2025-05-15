local gui_object_dom = require("../dom/gui_object")
local style_parser = require("./css_parser/gui_object")
local ui_corner_dom = require("../dom/ui_corner")

export type Style = typeof(setmetatable(
	{} :: {
		doms: {
			gui_object: {
				dom: gui_object_dom.GuiObjectDom,
				css_parser: typeof(style_parser),
			}?,
			ui_corner: {
				dom: ui_corner_dom.UICornerDom,
				style_js: (class: string, dom: ui_corner_dom.UICornerDom) -> (),
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
	get_style_js: (self: Style) -> string,
	with_gui_object: (self: Style, gui_object: GuiObject) -> Style,
	with_ui_corner: (self: Style, ui_corner: UICorner) -> Style,
}

local style = {} :: StyleImpl
style.__index = style

function style.new()
	local self = setmetatable({ }, style)
	self.doms = {}
	self.class = tostring(self)
	return self
end

function style.with_gui_object(self, gui_object)
	self.doms.gui_object = {
		dom = gui_object_dom.from_gui_object(gui_object),
		css_parser = style_parser,
	}
	return self
end

function style.with_ui_corner(self, ui_corner)
	self.doms.ui_corner = {
		dom = ui_corner_dom.from_ui_corner(ui_corner),
		style_js = function(class, dom) 
			return `(new UiCorner({class}, {dom.corner_radius.offset}, {dom.corner_radius.scale})).init()`
		end,
	}
	return self
end

function style.get_css(self)
	local css = ''
	local parse_css = {}
	local levels = {}

	for _, dom in (self.doms :: any) :: {
		[string]: {
			dom: any,
			css_parser: typeof(style_parser)?,
			style_js: (class: string, dom: ui_corner_dom.UICornerDom) -> (),
		}
	} do
		if dom.css_parser then
			for css_prop_name, css_format_callback in dom.css_parser do
				local css_value, level = css_format_callback(dom.dom)
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
	end
	
	for css_prop_name, css_prop_value in parse_css do
		css ..= `{css_prop_name}: {css_prop_value};\n`
	end

	return css
end

function style.get_style_js(self)
	local style_js = ''
	for _, dom in (self.doms :: any) :: {
		[string]: {
			dom: any,
			css_parser: typeof(style_parser)?,
			style_js: (class: string, dom: ui_corner_dom.UICornerDom) -> string,
		}
	} do
		if dom.style_js then
			style_js ..= dom.style_js(self.class, dom.dom) .. '\n'
		end
	end
	return style_js
end

return style
