-- LcCore Server Module - Admin

LcCore.Admin = {}

--- Check if a player is admin
---@param source number
---@return boolean
function LcCore.Admin.IsAdmin(source)
    local player = LcCore.GetPlayer(source)
    if not player then return false end
    local group = player.GetGroup()
    return group == LcCore.Groups.ADMIN or group == LcCore.Groups.SUPERADMIN
end

--- Set a player's group
---@param source number
---@param group string
function LcCore.Admin.SetGroup(source, group)
    local player = LcCore.GetPlayer(source)
    if not player then return end
    player.GetGroup(group)
    TriggerEvent('lc:groupChanged', source, group)
end

--- Kick a player
---@param source number
---@param reason string?
function LcCore.Admin.Kick(source, reason)
    DropPlayer(source, reason or 'Kicked by admin')
end

--- Ban a player
---@param source number
---@param reason string?
---@param duration number? -- seconds, nil = permanent
function LcCore.Admin.Ban(source, reason, duration)
    -- TODO: save ban to DB then kick
    LcCore.Admin.Kick(source, reason or 'Banned')
end
