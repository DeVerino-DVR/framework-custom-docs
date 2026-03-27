-- LcCore Shared - Core table & utilities (Lua 5.4)

local LcCore <const> = {}
LcCore.Callback = {}

-------------------------------------------------
-- Debug Print
-------------------------------------------------
---@param ... any
function LcCore.Print(...)
    if Config.Debug then
        print('[LcCore]', ...)
    end
end

-------------------------------------------------
-- Enums / Constants (Lua 5.4 <const>)
-------------------------------------------------
LcCore.Groups = {
    USER       = 'user',
    ADMIN      = 'admin',
    SUPERADMIN = 'superadmin',
}

-- Expose to global env
_ENV.LcCore = LcCore
