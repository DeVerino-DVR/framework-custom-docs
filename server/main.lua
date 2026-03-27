-- LcCore Server - Entry Point

LcCore.Players = {} -- [source] = Player

-------------------------------------------------
-- Init
-------------------------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print('[LcCore] ^2Server initialized^0')

    -- On resource restart: re-init all connected players
    for _, playerId in ipairs(GetPlayers()) do
        LcCore.InitPlayer(tonumber(playerId))
    end
end)

-------------------------------------------------
-- Get Discord ID from identifiers
-------------------------------------------------
---@param source number
---@return string?
function LcCore.GetDiscordId(source)
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.find(id, 'discord:') then
            return string.gsub(id, 'discord:', '')
        end
    end
    return nil
end

-------------------------------------------------
-- Init player (connect or resource restart)
-------------------------------------------------
---@param source number
function LcCore.InitPlayer(source)
    local discord = LcCore.GetDiscordId(source)
    if not discord then
        DropPlayer(source, 'Discord non detecte. Lance Discord avant de te connecter.')
        return
    end

    -- Save existing player data if resource restart
    if LcCore.Players[source] then
        LcCore.SavePlayer(source)
        LcCore.Players[source] = nil
    end

    -- Load characters from DB
    local charRows = MySQL.query.await('SELECT * FROM lc_characters WHERE discord = ?', { discord })
    local characters = {}

    for _, row in ipairs(charRows or {}) do
        local coords = Config.DefaultSpawn
        if row.coords then
            local c = type(row.coords) == 'string' and json.decode(row.coords) or row.coords
            if c then coords = vector3(c.x, c.y, c.z) end
        end

        local job = { name = Config.DefaultJob, grade = Config.DefaultJobGrade, label = Config.DefaultJobLabel }
        if row.job then
            job = type(row.job) == 'string' and json.decode(row.job) or row.job
        end

        local inventory = {}
        if row.inventory then
            inventory = type(row.inventory) == 'string' and json.decode(row.inventory) or row.inventory
        end

        local skin = {}
        if row.skin then
            skin = type(row.skin) == 'string' and json.decode(row.skin) or row.skin
        end

        local char = LcCore.CreateCharacter({
            charId    = row.id,
            discord   = discord,
            group     = row.group,
            firstname = row.firstname,
            lastname  = row.lastname,
            job       = job,
            gang      = row.gang,
            money     = row.money,
            gold      = row.gold,
            coords    = coords,
            inventory = inventory,
            slots     = row.slots,
            isDead    = row.isdead == 1,
            skin      = skin,
            xp        = row.xp,
        })
        characters[char.charId] = char
    end

    -- Create player object
    local player = LcCore.CreatePlayer(source, discord, characters)
    LcCore.Players[source] = player

    local charCount = player.getCharCount()

    if charCount == 0 then
        -- No characters -> creation screen
        TriggerClientEvent('lc:createCharacter', source)
    elseif charCount == 1 then
        -- Single char -> auto select & spawn direct
        local _, firstChar = next(characters)
        player.setActiveChar(firstChar.charId)
        TriggerClientEvent('lc:spawn', source, {
            charId    = firstChar.charId,
            firstname = firstChar.firstname,
            lastname  = firstChar.lastname,
            coords    = firstChar.coords,
            skin      = firstChar.skin,
            isDead    = firstChar.isDead,
        })
    else
        -- Multiple chars -> selection screen
        local charList = {}
        for charId, char in pairs(characters) do
            charList[#charList + 1] = {
                charId    = charId,
                firstname = char.firstname,
                lastname  = char.lastname,
                job       = char.job,
                money     = char.money,
                gold      = char.gold,
            }
        end
        TriggerClientEvent('lc:selectCharacter', source, charList)
    end

    LcCore.Print('Player initialized:', discord, '| Chars:', charCount)
end

-------------------------------------------------
-- Player connecting (ban check)
-------------------------------------------------
AddEventHandler('playerConnecting', function(_, _, deferrals)
    local source = source
    deferrals.defer()
    Wait(0)
    deferrals.update('Chargement...')

    local discord = LcCore.GetDiscordId(source)
    if not discord then
        deferrals.done('Discord non detecte. Lance Discord avant de te connecter.')
        return
    end

    local ban = MySQL.single.await('SELECT * FROM lc_bans WHERE discord = ? AND (expire IS NULL OR expire > NOW())', { discord })
    if ban then
        deferrals.done('Tu es banni: ' .. (ban.reason or 'Aucune raison'))
        return
    end

    deferrals.done()
end)

-------------------------------------------------
-- Player fully joined -> init
-------------------------------------------------
RegisterNetEvent('lc:playerJoined', function()
    local source = source
    LcCore.InitPlayer(source)
end)

-------------------------------------------------
-- Player selects a character
-------------------------------------------------
RegisterNetEvent('lc:charSelected', function(charId)
    local source = source
    local player = LcCore.GetPlayer(source)
    if not player then return end

    if not player.setActiveChar(charId) then return end

    local char = player.getActiveChar()
    TriggerClientEvent('lc:spawn', source, {
        charId    = char.charId,
        firstname = char.firstname,
        lastname  = char.lastname,
        coords    = char.coords,
        skin      = char.skin,
        isDead    = char.isDead,
    })
end)

-------------------------------------------------
-- Player creates a character
-------------------------------------------------
RegisterNetEvent('lc:charCreate', function(data)
    local source = source
    local player = LcCore.GetPlayer(source)
    if not player then return end

    if player.getCharCount() >= Config.MaxCharacters then
        TriggerClientEvent('lc:notify', source, 'Nombre max de personnages atteint', 'error')
        return
    end

    local discord = player.getDiscord()
    local defaultJob = json.encode({ name = Config.DefaultJob, grade = Config.DefaultJobGrade, label = Config.DefaultJobLabel })
    local defaultCoords = json.encode({ x = Config.DefaultSpawn.x, y = Config.DefaultSpawn.y, z = Config.DefaultSpawn.z })

    local charId = MySQL.insert.await(
        'INSERT INTO lc_characters (discord, firstname, lastname, job, gang, money, gold, coords, inventory, skin, slots, xp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        {
            discord,
            data.firstname,
            data.lastname,
            defaultJob,
            Config.DefaultGang,
            Config.DefaultMoney,
            Config.DefaultGold,
            defaultCoords,
            '[]',
            data.skin or '{}',
            Config.DefaultInventorySlots,
            0,
        }
    )

    local char = LcCore.CreateCharacter({
        charId    = charId,
        discord   = discord,
        firstname = data.firstname,
        lastname  = data.lastname,
    })

    player.addCharacter(char)
    player.setActiveChar(charId)

    TriggerClientEvent('lc:spawn', source, {
        charId    = charId,
        firstname = char.firstname,
        lastname  = char.lastname,
        coords    = Config.DefaultSpawn,
        skin      = char.skin,
        isDead    = false,
    })
end)

-------------------------------------------------
-- Player disconnect -> save & cleanup
-------------------------------------------------
AddEventHandler('playerDropped', function()
    local source = source
    LcCore.SavePlayer(source)
    LcCore.Players[source] = nil
end)

-------------------------------------------------
-- Getters
-------------------------------------------------

---@param source number
---@return table?
function LcCore.GetPlayer(source)
    return LcCore.Players[source]
end

---@return table
function LcCore.GetPlayers()
    return LcCore.Players
end

---@param discord string
---@return table?
function LcCore.GetPlayerByDiscord(discord)
    for _, player in pairs(LcCore.Players) do
        if player.getDiscord() == discord then
            return player
        end
    end
    return nil
end

---@param charId number
---@return table?
function LcCore.GetPlayerByCharId(charId)
    for _, player in pairs(LcCore.Players) do
        if player.getCharId() == charId then
            return player
        end
    end
    return nil
end
