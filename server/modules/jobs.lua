-- LcCore Server Module - Jobs

LcCore.Jobs = {}

--- Get all registered jobs
---@return table
function LcCore.Jobs.GetAll()
    -- TODO: return jobs from DB or cache
    return {}
end

--- Set a player's job
---@param source number
---@param job string
---@param grade number
---@param label string?
function LcCore.Jobs.Set(source, job, grade, label)
    local player = LcCore.GetPlayer(source)
    if not player then return end

    local char = player.GetCharacter()
    if not char then return end

    char.GetJob(job, grade, label)
    TriggerEvent('lc:jobChanged', source, job, grade)
end
