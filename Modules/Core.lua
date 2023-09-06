Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    return self
end

function Core:UpdateFrame()
    print("Hello!")
end

function Core:Run()
    Initializer:LoadAddOn(self, self.UpdateFrame)
end