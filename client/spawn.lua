-- LcCore Client - Spawn System

local hasSpawned = false

-------------------------------------------------
-- Receive spawn from server (single char or after selection)
-------------------------------------------------
RegisterNetEvent('lc:spawn', function(data)
    LcCore.SetActiveCharId(data.charId)

    SendNUIMessage({ action = 'hideSelection' })
    SetNuiFocus(false, false)

    LcCore.SpawnPlayer(data.coords, nil, function()
        if data.skin and next(data.skin) then
            -- skin application sera geree par le module skin
        end

        LcCore.SetLoaded(true)
        hasSpawned = true
        TriggerEvent('lc:playerSpawned', data.charId, data.firstname, data.lastname)
        LcCore.Print('Spawned as', data.firstname, data.lastname, '(charId:', data.charId, ')')
    end)
end)

-------------------------------------------------
-- Receive character selection (multi-char)
-------------------------------------------------
RegisterNetEvent('lc:selectCharacter', function(charList)
    hasSpawned = false
    LcCore.SetLoaded(false)

    SendNUIMessage({
        action = 'showSelection',
        characters = charList,
        maxCharacters = Config.MaxCharacters,
    })
    SetNuiFocus(true, true)
end)

-------------------------------------------------
-- Receive character creation prompt
-------------------------------------------------
RegisterNetEvent('lc:createCharacter', function()
    hasSpawned = false
    LcCore.SetLoaded(false)

    SendNUIMessage({
        action = 'showCreation',
        maxCharacters = Config.MaxCharacters,
    })
    SetNuiFocus(true, true)
end)

-------------------------------------------------
-- NUI Callbacks
-------------------------------------------------

RegisterNUICallback('selectChar', function(data, cb)
    TriggerServerEvent('lc:charSelected', data.charId)
    cb('ok')
end)

RegisterNUICallback('createChar', function(data, cb)
    TriggerServerEvent('lc:charCreate', {
        firstname = data.firstname,
        lastname  = data.lastname,
        skin      = data.skin or '{}',
    })
    cb('ok')
end)

-------------------------------------------------
-- Spawn Logic
-------------------------------------------------

---@param coords vector3
---@param heading number?
---@param onSpawned function?
function LcCore.SpawnPlayer(coords, heading, onSpawned)
    local ped <const> = PlayerPedId()

    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
    if heading then
        SetEntityHeading(ped, heading)
    end

    FreezeEntityPosition(ped, false)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

    if onSpawned then
        onSpawned()
    end
end
