export type Color = {
    r: number,
    g: number,
    b: number,
}

export type Ui2 = {
    x: {
        offset: number,
        scale: number,
    },
    y: {
        offset: number,
        scale: number,
    },
}

export type Vec2 = { 
    x: number, 
    y: number,
}

export type AutomaticSize = "None" 
    | "X" 
    | "Y" 
    | "XY"

export type BorderMode = "Outline"
    | "Middle"
    | "Inset"

export type SizeConstraint = "RelativeXY"
    | "RelativeXX"
    | "RelativeYY"

export type GuiObjectDomProps = {
    active: boolean,
    anchord_point: Vec2,
    automatic_size: AutomaticSize,
    background_color: Color,
    background_transparency: number,
    border_color: Color,
    border_mode: BorderMode,
    border_size: number,
    clips_descendants: boolean,
    interactable: boolean,
    layout_order: number,
    position: Ui2,
    rotation: number,
    size: Ui2,
    size_constraint: SizeConstraint,
    visible: boolean,
    z_index: number,
}

export type GuiObjectDom = typeof(setmetatable({} :: GuiObjectDomProps, {} :: any))

return {}
