-- LcCore Server Class - Character
-- Data structure for a character row in lc_characters

---@param data table
---@return table
function LcCore.CreateCharacter(data)
    local self = {}

    self.charId    = data.charId or 0
    self.discord   = data.discord or ''
    self.group     = data.group or Config.DefaultGroup
    self.firstname = data.firstname or ''
    self.lastname  = data.lastname or ''
    self.job       = data.job or { name = Config.DefaultJob, grade = Config.DefaultJobGrade, label = Config.DefaultJobLabel }
    self.gang      = data.gang or Config.DefaultGang
    self.money     = data.money or Config.DefaultMoney
    self.gold      = data.gold or Config.DefaultGold
    self.coords    = data.coords or Config.DefaultSpawn
    self.inventory = data.inventory or {}
    self.slots     = data.slots or Config.DefaultInventorySlots
    self.isDead    = data.isDead or false
    self.skin      = data.skin or {}
    self.xp        = data.xp or 0

    return self
end
