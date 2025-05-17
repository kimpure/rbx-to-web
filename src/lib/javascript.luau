local javascript = {}

javascript.config = {}
javascript.config.tab = '    '

javascript.utils = {}
javascript.utils.class = {}
javascript.utils.class.formatLuauMetatableName = function(metatable: any)
    return `luau_{string.gsub(string.gsub(tostring(metatable), ' ', ''), ':', '')}`
end
javascript.utils.dataType = {}
javascript.utils.dataType.formatLuauData = function(data: any)
    local dataType = type(data)

    if dataType == 'string' then
        return `'{data}'`
    end

    if dataType == 'nil' then
        return 'undefined'
    end

    if dataType == 'table' then
        local source = '{\n'

        for key, value in data do
            if type(value) == 'table' then
                source ..= string.gsub(`{javascript.config.tab}['{key}']: {javascript.utils.dataType.formatLuauData(value)}, `, '\n', '\n' .. javascript.config.tab) .. '\n'

                continue
            end
            source ..= `{javascript.config.tab}['{key}']: {javascript.utils.dataType.formatLuauData(value)}, \n`
        end

        return source .. '}'
    end

    return data
end

javascript.parameter = {}
javascript.parameter.__index = javascript.parameter
javascript.parameter.create = function(...: any)
    local self = setmetatable({}, javascript.parameter)
    
    self.args = table.pack(...)
    
    return self
end
javascript.parameter.getSource = function(self: typeof(javascript.parameter.create()))
    local source = ''
    
    for i=1, self.args.n do
        source ..= javascript.utils.dataType.formatLuauData(self.args[i])

        if i ~= self.args.n then
            source ..= ', '
        end
    end

    return source
end

javascript.class = {}
javascript.class.__index = javascript.class
javascript.class.create = function(className: string, ...: any)
    local self = setmetatable({}, javascript.class)
    
    self.args = javascript.parameter.create(...)
    self.name = className
    self.methods = {} :: { 
        [number]: {
            args: typeof(javascript.parameter.create()),
            name: string,
        }
    }
    
    return self
end
javascript.class.method = function(self: typeof(javascript.class.create('')), methodName: string, ...: any)
    self.methods[#self.methods + 1] = {
        args = javascript.parameter.create(...),
        name = methodName,
    }
    
    return self
end
javascript.class.getSource = function(self: typeof(javascript.class.create(''))) return '' end
javascript.class.getSource = function(self: typeof(javascript.class.create('')))
    local source = `const {javascript.utils.class.formatLuauMetatableName(self)} = new {self.name}({self.args:getSource()});\n`
    
    for i=1, #self.methods do
        source ..= `{javascript.utils.class.formatLuauMetatableName(self)}.{self.methods[i].name}({self.methods[i].args:getSource()});`

        if i ~= #self.methods then
            source ..= '\n'
        end
    end

    return source
end

return javascript
