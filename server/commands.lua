-- LcCore Server - Commands

LcCore.Commands = {}

---@param name string
---@param group string|table
---@param cb function
---@param suggestion table?
function LcCore.Commands.Register(name, group, cb, suggestion)
    RegisterCommand(name, function(source, args, rawCommand)
        local player = LcCore.GetPlayer(source)
        if not player then return end

        local playerGroup = player.getGroup()
        local allowed = false

        if type(group) == 'table' then
            for _, g in ipairs(group) do
                if playerGroup == g then
                    allowed = true
                    break
                end
            end
        else
            allowed = (playerGroup == group) or (group == LcCore.Groups.USER)
        end

        if not allowed then return end
        cb(source, args, rawCommand)
    end, false)

    if suggestion then
        TriggerEvent('chat:addSuggestion', '/' .. name, suggestion.help, suggestion.params)
    end
end
