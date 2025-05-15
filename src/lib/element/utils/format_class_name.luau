return function(class: any): string
    return `luau_{string.gsub(string.gsub(tostring(class), ' ', ''), ':', '')}`
end
