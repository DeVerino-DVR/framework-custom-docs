-- LcCore Server - Commands

LcCore.Commands = {}

--- Register a command with permission check
---@param name string
---@param group string|table -- group(s) allowed
---@param cb function
---@param suggestion table? -- { help = '', params = {} }
function LcCore.Commands.Register(name, group, cb, suggestion)
    RegisterCommand(name, function(source, args, rawCommand)
        local player = LcCore.GetPlayer(source)
        if not player then return end

        local allowed = false
        local playerGroup = player.GetGroup()

        if type(group) == 'table' then
            for _, g in ipairs(group) do
                if playerGroup == g then allowed = true break end
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
