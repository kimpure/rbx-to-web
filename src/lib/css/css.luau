local gui_object_dom = require("../dom/gui_object")
local gui_object_parser = require("./parser/gui_object")
local ui_corner_dom = require("../dom/ui_corner")
local ui_corner_parser = require("./parser/ui_corner")

export type GuiObjectCss = typeof(setmetatable(
	{} :: {
		doms: {
			gui_object_dom: {
				dom: gui_object_dom.GuiObjectDom,
				parser: typeof(gui_object_parser),
			},
			ui_corner_dom: {
				dom: ui_corner_dom.UICornerDom,
				parser: typeof(ui_corner_parser),
			}?,
		},
	},
	{} :: GuiObjectCssImpl
))

export type GuiObjectCssImpl = {
	__index: GuiObjectCssImpl,
	from_gui_object: (gui_object: GuiObject) -> GuiObjectCss,
	get_css: (self: GuiObjectCss) -> string,
	with_ui_corner: (self: GuiObjectCss, ui_corner: UICorner) -> GuiObjectCss,
}

local gui_object_css = {} :: GuiObjectCssImpl
gui_object_css.__index = gui_object_css

function gui_object_css.from_gui_object(gui_object: GuiObject)
	return setmetatable({
		doms = {
			gui_object_dom = {
				dom = gui_object_dom.from_gui_object(gui_object),
				parser = gui_object_parser,
			},
		},
	}, gui_object_css)
end

function gui_object_css.with_ui_corner(self, ui_corner)
	self.doms.ui_corner_dom = {
		dom = ui_corner_dom.from_ui_corner(ui_corner),
		parser = ui_corner_parser,
	}
	return self
end

function gui_object_css.get_css(self)
	local css = ""

	for dom_name, dom_info in (self.doms :: any) :: { [string]: { dom: { [string]: any }, parser: { [string]: (...any) -> string } } } do
		for name, callback in dom_info.parser do
			local parse_css = callback(dom_info.dom)
			if not parse_css then
				continue
			end

			css ..= `{name}: {parse_css};\n`
		end
	end

	return css
end

return gui_object_css
