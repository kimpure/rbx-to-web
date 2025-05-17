local function format_datatype(value: any)
    local value_type = type(value)
    
    if value_type == 'nil' then
        return 'undefined'
    end
    
    if value_type == 'string' then
        return '\'' .. value .. '\''
    end

    return value
end

return {
    class = function(class_name: string, ...: any)
        local self = {
            source = `(new {class_name}(`,
        }
        
        local args = table.pack(...)

        for i=1, args.n do
            args[i] = format_datatype(args[i])

            self.source ..= args[i] 
            
            if i ~= args.n then
                self.source ..= ', '
            end
        end

        self.source ..= '))'

        local impl = {}
        impl.__index = impl

        impl.mathod = function(self: typeof(setmetatable(self, impl)), method_name: string, ...: any?)
            self.source ..= `.{method_name}(`

            local args = table.pack(...)

            for i=1, args.n do
                args[i] = format_datatype(args[i])
                
                self.source ..= args[i] 
            
                if i ~= args.n then
                    self.source ..= ', '
                end
            end

            self.source ..= ')'

            return self
        end

        impl.get_source = function(self: typeof(setmetatable(self, impl)))
            return self.source .. ';'
        end

        return setmetatable(self, impl)
    end,
}
