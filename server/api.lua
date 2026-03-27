-- LcCore Server - API / Exports

local Core = {}

Core.GetPlayer          = LcCore.GetPlayer
Core.GetPlayers         = LcCore.GetPlayers
Core.GetPlayerByDiscord = LcCore.GetPlayerByDiscord
Core.GetPlayerByCharId  = LcCore.GetPlayerByCharId
Core.Callback           = LcCore.Callback
Core.SavePlayer         = LcCore.SavePlayer
Core.SaveAll            = LcCore.SaveAll

exports('GetCore', function()
    return Core
end)
