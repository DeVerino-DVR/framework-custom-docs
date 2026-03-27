-- LcCore Server - API / Exports

local Core <const> = {}

Core.GetPlayer          = LcCore.GetPlayer
Core.GetPlayers         = LcCore.GetPlayers
Core.GetPlayerByDiscord = LcCore.GetPlayerByDiscord
Core.GetPlayerByCharId  = LcCore.GetPlayerByCharId
Core.GetSourceByCharId  = LcCore.GetSourceByCharId
Core.Callback           = LcCore.Callback
Core.Economy            = LcCore.Economy
Core.Admin              = LcCore.Admin
Core.Commands           = LcCore.Commands
Core.Cron               = LcCore.Cron
Core.SavePlayer         = LcCore.SavePlayer
Core.SaveAll            = LcCore.SaveAll

exports('GetCore', function()
    return Core
end)
