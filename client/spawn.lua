-- LcCore Client - Spawn System

local hasSpawned = false

-------------------------------------------------
-- Receive spawn from server (single char or after selection)
-------------------------------------------------
RegisterNetEvent('lc:spawn', function(data)
    LcCore.SetActiveCharId(data.charId)

    -- Hide any NUI (selection screen)
    SendNUIMessage({ action = 'hideSelection' })
    SetNuiFocus(false, false)

    -- Spawn the player
    LcCore.SpawnPlayer(data.coords, nil, function()
        -- Apply skin if present
        if data.skin and data.skin ~= '{}' then
            -- TODO: apply skin from JSON
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

    -- Send char list to NUI
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

-- Player selected a character from NUI
RegisterNUICallback('selectChar', function(data, cb)
    TriggerServerEvent('lc:charSelected', data.charId)
    cb('ok')
end)

-- Player created a character from NUI
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

--- Spawn the player at coordinates
---@param coords vector3
---@param heading number?
---@param onSpawned function?
function LcCore.SpawnPlayer(coords, heading, onSpawned)
    local ped = PlayerPedId()

    -- Freeze and set position
    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
    if heading then
        SetEntityHeading(ped, heading)
    end

    -- Unfreeze
    FreezeEntityPosition(ped, false)

    -- Remove loading screen
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

    if onSpawned then
        onSpawned()
    end
end

-------------------------------------------------
-- Death handling
-------------------------------------------------
function LcCore.HandleDeath()
    -- TODO: death/respawn logic
end
