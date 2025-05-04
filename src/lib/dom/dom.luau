local gui_object = require('./gui/object')
local gui_base2d = require('./gui/base2d')

export type GuiObjectDom =  gui_object.GuiObjectDom
export type UIAspectRatioConstraintDom = gui_base2d.UIAspectRatioConstraintDom
export type UICornerDom = gui_base2d.UICornerDom

return {
    gui_object = gui_object,
    gui_base2d = gui_base2d,
}
