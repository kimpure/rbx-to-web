local javascript = require('./javascript')
local element = require('./element')

local dom = {}

local GuiObjectDom = {}
GuiObjectDom.__index = GuiObjectDom

export type GuiObjectDom = typeof(setmetatable({} :: {
    parent: GuiObjectDom?,
    class: string,
    element: typeof(element.GuiObject.create(0 :: any)),
    javascript: javascript.Class,
}, GuiObjectDom))

function GuiObjectDom.create(guiObject: GuiObject)
    local self = setmetatable({}, guiObject)
    
    self.parent = nil
    self.class = javascript.Utils.formatLuauMetatableName(self)
    self.element = element.GuiObject.create(guiObject)
    self.javascript = javascript.Class.create('GuiObject', self.element):method('apply')
    
    return self
end

local UiCornerDom = {}
UiCornerDom.__index = UiCornerDom

export type UiCornerDom = typeof(setmetatable({} :: {
    parent: GuiObjectDom?,
    element: typeof(element.UiCorner.create(0 :: any)),
    javascript: javascript.Class,
}, UiCornerDom))

function UiCornerDom.create(uiCorner: UICorner)
    local self = setmetatable({}, uiCorner)

    self.parent = nil
    self.element = element.UiCorner.create(uiCorner)
    self.javascript = javascript.Class.create('UiCorner', self.element):method('apply')

    return self
end

dom.GuiObject = GuiObjectDom
dom.UiCorner = UiCornerDom

return dom
