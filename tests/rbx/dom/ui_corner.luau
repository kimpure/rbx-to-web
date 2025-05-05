export type DomProps = Frame 
    | TextLabel 
    | TextBox 
    | TextButton 
    | ImageLabel 
    | ImageButton

local fs = require('@lune/fs')
local roblox = require('@lune/roblox')

local test_asset = fs.readFile('tests/rbx/assets/ui_corner.rbxm')

local dom = roblox.deserializeModel(test_asset) :: any

return dom[1] :: DomProps
