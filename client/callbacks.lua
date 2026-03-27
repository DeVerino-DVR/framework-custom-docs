-- LcCore Client - Callback System (ox_lib style, return-based)
-- Usage: local data = LcCore.Callback.Await('getPlayerData')

local pending = {}
local cbId = 0

--- Await a server callback (synchronous, returns directly)
--- Usage: local name, money = LcCore.Callback.Await('getData')
---@param name string
---@param ... any
---@return any ...
function LcCore.Callback.Await(name, ...)
    cbId = cbId + 1
    local id = cbId
    local p = promise.new()
    pending[id] = p
    TriggerServerEvent('lc:cb:request', name, id, ...)
    return table.unpack(Citizen.Await(p))
end

--- Receive response from server
RegisterNetEvent('lc:cb:response', function(id, ...)
    local p = pending[id]
    if not p then return end
    pending[id] = nil
    p:resolve({ ... })
end)
