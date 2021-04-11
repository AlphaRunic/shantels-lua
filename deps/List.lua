local from = require "import"
from "lua-pie" : import "*"
from "pretty-print" : import "dump"

local List
List = class "List" {
    public {
        constructor = function(self, precache)
            self.cache = precache or {}
        end;

        Push = function(self, value)
            table.insert(self.cache, value)
            return List(self.cache)
        end;

        Pop = function(self)
            local index = #self.cache
            table.remove(self.cache, index)
            return List(self.cache)
        end;

        ForEach = function(self, callback)
            for _, value in pairs(self.cache) do
                callback(value)
            end
        end;

        ForEachI = function(self, callback)
            for index, value in pairs(self.cache) do
                callback(value, index)
            end
        end;

        Filter = function(self, predicate)
            local res = List()
            self:ForEachI(function(element, index)
                if predicate(element, index) then
                    res:Push(element)
                end
            end)
            return res
        end;
        
        ToTable = function(self)
            return self.cache
        end;
    };

    operators {
        __tostring = function(self)
            return dump(self.cache)
        end;
    }
}

return {
    List = List
}