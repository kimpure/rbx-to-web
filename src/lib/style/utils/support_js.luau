local support_js = {}

function support_js.class(class_name: string, ...: any)

end

return {
    class = function(class_name: string, ...: any)
        local self = {
            source = `(new {class_name}(`,
        }
        
        local args = table.pack(...)

        for i=1, args.n do
            if args[i] == nil then
                args[i] = 'undefined'
            end

            if type(args[i]) == 'string' then
                args[i] = '\'' .. args[i] .. '\''
            end
            
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
                if args[i] == nil then
                    args[i] = 'undefined'
                end

                if type(args[i]) == 'string' then
                    args[i] = '\'' .. args[i] .. '\''
                end
                
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
    end
}
