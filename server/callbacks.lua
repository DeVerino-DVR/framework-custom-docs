-- LcCore Server - Callback System (ox_lib style)

local registered = {}

--- Register a server callback
--- Usage: LcCore.Callback.Register('getName', function(source) return 'John' end)
---@param name string
---@param cb function
function LcCore.Callback.Register(name, cb)
    registered[name] = cb
end

--- Handle incoming callback request from client
RegisterNetEvent('lc:cb:request', function(name, id, ...)
    local source = source
    if not registered[name] then return end
    local result = { registered[name](source, ...) }
    TriggerClientEvent('lc:cb:response', source, id, table.unpack(result))
end)
