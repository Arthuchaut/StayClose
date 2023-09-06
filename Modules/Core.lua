Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    return self
end

function Core:UpdateFrame()
    if StayCloseSettings.variable.distanceWatcherEnabled then
        local playerPosition = Localization:GetWorldPosition("player")

        if UnitExists(StayCloseSettings.variable.targetID) then
            -- local targetPosition = Localization:GetWorldPosition(StayCloseSettings.variable.targetID)
            local targetPosition = Position.New(-8825, 634) -- The place near the auction house in Stomwind
            local distance = Localization:GetEuclideanDistance(playerPosition, targetPosition)

            if distance >= StayCloseSettings.variable.minSafetyDistance then
                local bearing = Localization:GetRelativeBearing(playerPosition, targetPosition)
                print("Careful!", distance, bearing)
            end
        end
    end
end

function Core:Run()
    Initializer:LoadAddOn(self, self.UpdateFrame)
end