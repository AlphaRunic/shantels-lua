local extensions = require "extensions"
extensions()

local import
import = function(t)
    if type(t) == "table" then
        for key, fn in pairs(t) do
            _G[key] = fn
        end
    elseif type(t) == "string" then
        return {
            import = function(self, libs)
                local module = require(t)
                if libs == "*" then
                    import(module)
                else
                    local trimmed = libs:gsub("%s+", "")
                    local libList = trimmed:split(",")

                    local toImport = {}
                    for _, lib in pairs(libList) do
                        toImport[lib] = module[lib]
                    end
                    
                    import(toImport)
                end
            end;
        }
    end
end

return import