local gui_object_dom = require('./gui_object')

export type DominantAxis = "Width" | "Height"

export type AspectType = 'FitWithinMaxSize' | 'ScaleWithParentSize'

export type UIAspectRatioConstraintDomProps = {
	aspect_ratio: number,
	aspect_type: AspectType,
	dominant_axis: DominantAxis,
	parent: gui_object_dom.GuiObjectDom?,
}

export type UIAspectRatioConstraintDom = typeof(setmetatable({} :: UIAspectRatioConstraintDomProps, {}))

local ui_aspect_ratio_constraint_dom_parser = {}
ui_aspect_ratio_constraint_dom_parser["AspectRatio"] = function(dom: UIAspectRatioConstraintDom, value: number)
	dom.aspect_ratio = value
end
ui_aspect_ratio_constraint_dom_parser["AspectType"] = function(dom: UIAspectRatioConstraintDom, value: Enum.AspectType) 
	dom.aspect_type = value.Name :: AspectType
end
ui_aspect_ratio_constraint_dom_parser["DominantAxis"] = function(dom: UIAspectRatioConstraintDom, value: Enum.DominantAxis)
	dom.dominant_axis = value.Name :: DominantAxis
end

local function from_ui_aspect_ratio_constraint(ui_aspect_ratio_constraint: UIAspectRatioConstraint)
	local dom = setmetatable({}, {}) :: UIAspectRatioConstraintDom

	for propname, callback in
		ui_aspect_ratio_constraint_dom_parser :: { [string]: (dom: UIAspectRatioConstraintDom, value: any) -> () }
	do
		callback(dom, (ui_aspect_ratio_constraint :: any)[propname])
	end

	return dom
end

return {
	from_ui_aspect_ratio_constraint = from_ui_aspect_ratio_constraint,
}
