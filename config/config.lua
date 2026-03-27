local Config <const> = {}

-------------------------------------------------
-- General
-------------------------------------------------
Config.Debug = true

-------------------------------------------------
-- Character
-------------------------------------------------
Config.MaxCharacters = 1 -- 1 = spawn direct, 2+ = selection screen
Config.DefaultJob = 'unemployed'
Config.DefaultJobGrade = 0
Config.DefaultJobLabel = 'Sans emploi'
Config.DefaultGang = 'none'
Config.DefaultGroup = 'user' -- user | admin | superadmin

-------------------------------------------------
-- Economy
-------------------------------------------------
Config.DefaultMoney = 50.0
Config.DefaultGold = 0.0

-------------------------------------------------
-- Spawn
-------------------------------------------------
Config.DefaultSpawn = vector3(-279.22, 805.39, 119.37)
Config.DefaultSpawnHeading = 90.0

-------------------------------------------------
-- Player
-------------------------------------------------
Config.MaxHealth = 10
Config.MaxStamina = 10
Config.PvP = true

-------------------------------------------------
-- Inventory
-------------------------------------------------
Config.DefaultInventorySlots = 50

-------------------------------------------------
-- Respawn
-------------------------------------------------
Config.RespawnTime = 60 -- secondes

Config.HospitalLocations = {
    { name = 'Valentine',    coords = vector3(-279.22, 805.39, 119.37) },
    { name = 'Saint Denis',  coords = vector3(2721.73, -1443.53, 46.75) },
    { name = 'Blackwater',   coords = vector3(-757.18, -1275.59, 44.08) },
    { name = 'Rhodes',       coords = vector3(1226.0, -1312.73, 77.04) },
    { name = 'Armadillo',    coords = vector3(-3731.53, -2601.53, -13.83) },
}

-------------------------------------------------
-- Saves
-------------------------------------------------
Config.AutoSaveInterval = 300 -- secondes (5 min)

-------------------------------------------------
-- Webhooks (Discord)
-------------------------------------------------
Config.Webhooks = {
    logs    = '',
    admin   = '',
    economy = '',
    joins   = '',
}

_ENV.Config = Config