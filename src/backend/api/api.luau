local element = require('./element')
local roblox = require('@lune/roblox')
local net = require('@lune/net')
local serde = require('@lune/serde')

return function(port: number)
    net.serve(port, function(request)
        if request.method ~= 'POST' then
            return {
                status = 404,
            }
        end
        
        if request.path == '/api/rbxm/gui-object' then
            local guiObject = (roblox.deserializeModel(request.body)[1] :: any) :: GuiObject
            local guiObjectElement = element.guiObjectElement.create(guiObject)
            return {
                status = 200,
                headers = {
					["Content-Type"] = "application/json",
				},
                body = serde.encode('json', guiObjectElement)
            }
        end
        
        return {
            status = 404,
        }
    end)
end
