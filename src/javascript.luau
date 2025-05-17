local javascript = {}

local Config = {}
Config.tab = '    '

local Utils = {}

function Utils.formatLuauMetatableName(metatable: any)
    return `luau_{string.gsub(string.gsub(tostring(metatable), ' ', ''), ':', '')}`
end

function Utils.formatLuauData(data: any)
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
                source ..= string.gsub(`{Config.tab}['{key}']: {Utils.formatLuauData(value)}, `, '\n', '\n' .. Config.tab) .. '\n'

                continue
            end
            source ..= `{Config.tab}['{key}']: {Utils.formatLuauData(value)}, \n`
        end

        return source .. '}'
    end

    return data
end

local Parameter = {}
Parameter.__index = Parameter

export type Parameter = typeof(setmetatable({} :: {
    args: { 
        [number]: any, 
        n: number,
    },
}, Parameter))

function Parameter.create(...: any): Parameter
    local self = setmetatable({}, Parameter)
    
    self.args = table.pack(...)
    
    return self
end

function Parameter.getSource(self: Parameter): string
    local source = ''
    
    for i=1, self.args.n do
        source ..= Utils.formatLuauData(self.args[i])

        if i ~= self.args.n then
            source ..= ', '
        end
    end

    return source
end

local Class = {}
Class.__index = Class

export type Class = typeof(setmetatable({} :: {
    args: Parameter,
    name: string,
    methods: {
        [number]: {
            args: Parameter,
            name: string,
        }
    }
}, Class))

function Class.create(className: string, ...: any): Class
    local self = setmetatable({}, Class)
    
    self.args = Parameter.create(...)
    self.name = className
    self.methods = {}
    
    return self
end

function Class.method(self: Class, methodName: string, ...: any): Class
    self.methods[#self.methods + 1] = {
        args = Parameter.create(...),
        name = methodName,
    }
    
    return self
end

function Class.getSource(self: Class): string
    local source = `const {Utils.formatLuauMetatableName(self)} = new {self.name}({self.args:getSource()});\n`
    
    for i=1, #self.methods do
        source ..= `{Utils.formatLuauMetatableName(self)}.{self.methods[i].name}({self.methods[i].args:getSource()});`

        if i ~= #self.methods then
            source ..= '\n'
        end
    end

    return source
end

javascript.Config = Config
javascript.Utils = Utils
javascript.Class = Class
javascript.Parameter = Parameter

return javascript
