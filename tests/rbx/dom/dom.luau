export type DomProps = Frame 
    | TextLabel 
    | TextBox 
    | TextButton 
    | ImageLabel 
    | ImageButton

local fs = require('@lune/fs')
local roblox = require('@lune/roblox')

local test_asset = fs.readFile('tests/rbx/assets/frame2.rbxm')

local dom = roblox.deserializeModel(test_asset) :: any

return dom[1] :: DomProps
