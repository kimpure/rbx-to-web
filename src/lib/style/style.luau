local gui_object_dom = require("../dom/gui_object")
local gui_object_css_parser = require("./css_parser/gui_object")
local ui_corner_dom = require("../dom/ui_corner")
local ui_aspect_ratio_constraint_dom = require('../dom/ui_aspect_ratio_constraint')
local ui_aspect_ratio_constraint_css_parser = require('./css_parser/ui_aspect_ratio_constraint')

local support_js = require('./utils/support_js')

local format_class_name = require('../element/utils/format_class_name')

export type Style = typeof(setmetatable(
	{} :: {
		doms: {
			gui_object: {
				dom: gui_object_dom.GuiObjectDom,
				css_parser: typeof(gui_object_css_parser),
			}?,
			ui_corner: {
				dom: ui_corner_dom.UICornerDom,
				style_js: (class: string, dom: ui_corner_dom.UICornerDom) -> string,
			}?,
			ui_aspect_ratio_constraint: {
				dom: ui_aspect_ratio_constraint_dom.UIAspectRatioConstraintDom,
				css_parser: typeof(ui_aspect_ratio_constraint_css_parser),
				style_js: (class: string, dom: ui_aspect_ratio_constraint_dom.UIAspectRatioConstraintDom) -> string,
			}?
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
	with_ui_aspect_ratio_constraint: (self: Style, ui_aspect_ratio_constraint: UIAspectRatioConstraint) -> Style,
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
	local dom = gui_object_dom.from_gui_object(gui_object)
	if self.doms.ui_aspect_ratio_constraint then
		self.doms.ui_aspect_ratio_constraint.dom.parent = dom
	end
	self.doms.gui_object = {
		dom = dom,
		css_parser = gui_object_css_parser,
	}
	return self
end

function style.with_ui_aspect_ratio_constraint(self, ui_aspect_ratio_constraint)
	local dom = ui_aspect_ratio_constraint_dom.from_ui_aspect_ratio_constraint(ui_aspect_ratio_constraint)
	if self.doms.gui_object then
		dom.parent = self.doms.gui_object.dom
	end
	self.doms.ui_aspect_ratio_constraint = {
		dom = dom,
		css_parser = ui_aspect_ratio_constraint_css_parser,
		style_js = function(class, dom)
			if not dom.parent then
				return ''
			end

			if dom.aspect_type ~= 'FitWithinMaxSize' then
				return ''
			end
			
			return support_js.class('UiAspectRatioConstraint', 
				format_class_name(class), 
				dom.parent.size.x.offset,
				dom.parent.size.x.scale,
				dom.parent.size.y.offset,
				dom.parent.size.y.scale,
				dom.aspect_ratio
			):mathod('apply'):get_source()
		end
	}
	return self
end

function style.with_ui_corner(self, ui_corner)
	self.doms.ui_corner = {
		dom = ui_corner_dom.from_ui_corner(ui_corner),
		style_js = function(class, dom) 
			return support_js.class('UiCorner', 
				format_class_name(class), 
				dom.corner_radius.offset, 
				dom.corner_radius.scale
			):mathod('apply'):get_source()
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
			css_parser: { [string]: (...any) -> (any, number?) }?,
			style_js: (class: string, dom: ui_corner_dom.UICornerDom) -> string,
		}
	} do
		if not dom.css_parser then
			continue
		end
		
		for css_prop_name, css_format_callback in dom.css_parser do
			local css_value, level = css_format_callback(dom.dom)
			level = level or 1

			if not levels[css_prop_name] then
				levels[css_prop_name] = level
			end

			if levels[css_prop_name] > level then
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

function style.get_style_js(self)
	local style_js = ''
	for _, dom in (self.doms :: any) :: {
		[string]: {
			dom: any,
			css_parser: { [string]: (...any) -> (any, number?) }?,
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
