-- LcCore Client Module - Utilities

--- Load a model with timeout
---@param model string|number
---@return boolean
function LcCore.LoadModel(model)
    local hash = type(model) == 'string' and GetHashKey(model) or model
    RequestModel(hash)
    local timeout = 0
    while not HasModelLoaded(hash) and timeout < 5000 do
        Wait(10)
        timeout = timeout + 10
    end
    return HasModelLoaded(hash)
end

--- Load an animation dictionary
---@param dict string
---@return boolean
function LcCore.LoadAnimDict(dict)
    RequestAnimDict(dict)
    local timeout = 0
    while not HasAnimDictLoaded(dict) and timeout < 5000 do
        Wait(10)
        timeout = timeout + 10
    end
    return HasAnimDictLoaded(dict)
end

--- Draw 3D text at position
---@param coords vector3
---@param text string
function LcCore.Draw3DText(coords, text)
    -- TODO: draw text logic
end
