local element = {}

local GuiObject = {}

function GuiObject.create(guiObject: GuiObject)
    local guiObjectElement = {}

    guiObjectElement.active = guiObject.Active
    guiObjectElement.anchordPoint = { 
        x = guiObject.AnchorPoint.X,
        y = guiObject.AnchorPoint.Y,
    }
    guiObjectElement.backgroundColor = {
        r = guiObject.BackgroundColor3.R,
        g = guiObject.BackgroundColor3.G,
        b = guiObject.BackgroundColor3.B,
    }
    guiObjectElement.backgroundTransparency = guiObject.BackgroundTransparency
    guiObjectElement.borderMode = guiObject.BorderMode.Name
    guiObjectElement.borderSize = guiObject.BorderSizePixel
    guiObjectElement.clipsDescendants = guiObject.ClipsDescendants
    guiObjectElement.position = {
        x = {
            offset = guiObject.Position.X.Offset,
            scale = guiObject.Position.X.Scale,
        },
        y = {
            offset = guiObject.Position.Y.Offset,
            scale = guiObject.Position.Y.Scale,
        },
    }
    guiObjectElement.rotation = guiObjectElement.rotation
    guiObjectElement.size = {
        x = {
            offset = guiObject.Size.X.Offset,
            scale = guiObject.Size.X.Scale,
        },
        y = {
            offset = guiObject.Size.Y.Offset,
            scale = guiObject.Size.Y.Scale,
        }
    }
    guiObjectElement.sizeConstraint = guiObject.SizeConstraint.Name
    guiObjectElement.visible = guiObject.Visible
    guiObjectElement.zIndex = guiObject.ZIndex

    return guiObjectElement
end

local UiCorner = {}

function UiCorner.create(uiCorner: UICorner)
    local uiCornerElement = {
        cornerRadius = {
            offset = uiCorner.CornerRadius.Offset,
            scale = uiCorner.CornerRadius.Scale
        },
    }

    return uiCornerElement
end

element.GuiObject = GuiObject
element.UiCorner = UiCorner

return element
