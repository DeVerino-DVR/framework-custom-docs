-- LcCore Client - Entry Point

local isLoaded = false
local activeCharId = nil

-------------------------------------------------
-- On resource start (first connect or restart)
-------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    LcCore.Print('Client initialized')

    -- Tell server we're ready (handles both first connect and resource restart)
    TriggerServerEvent('lc:playerJoined')
end)

-------------------------------------------------
-- On resource stop -> cleanup
-------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    isLoaded = false
    activeCharId = nil
    SendNUIMessage({ action = 'hide' })
end)

-------------------------------------------------
-- State
-------------------------------------------------

---@return boolean
function LcCore.IsReady()
    while not isLoaded do
        Wait(100)
    end
    return true
end

---@param state boolean
function LcCore.SetLoaded(state)
    isLoaded = state
end

---@return number?
function LcCore.GetActiveCharId()
    return activeCharId
end

---@param charId number
function LcCore.SetActiveCharId(charId)
    activeCharId = charId
end
