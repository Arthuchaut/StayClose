Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    self.distanceAlert = DistanceAlert.New()
    self.instanceAlert = InstanceAlert.New()
    return self
end

function Core:UpdateFrame()
    if StayCloseSettings.core.distanceWatcherEnabled then
        local playerPosition = Localization:GetWorldPosition("player")

        if UnitExists(StayCloseSettings.core.targetID) then
            local targetPosition = Localization:GetWorldPosition(StayCloseSettings.core.targetID)
            -- local targetPosition = Position.New(-8825, 634, 0) -- A place near the auction house in Stomwind

            if playerPosition.mapID ~= targetPosition.mapID then
                if not self.instanceAlert:IsEnabled() then
                    self.instanceAlert:EnableAlert()
                end
            elseif self.instanceAlert:IsEnabled() then
                self.instanceAlert:DisableAlert()
            else
                local playerDistanceFromTarget = Localization:GetEuclideanDistance(playerPosition,
                    targetPosition)

                if playerDistanceFromTarget >= StayCloseSettings.core.safetyRadius then
                    local playerBearing = Localization:GetRelativeBearing(playerPosition, targetPosition)
                    self.distanceAlert:UpdateDistanceInfo(playerDistanceFromTarget)
                    self.distanceAlert:UpdateBearingInfo(playerBearing)

                    if not self.distanceAlert:IsEnabled() then
                        self.distanceAlert:EnableAlert()
                    end
                elseif self.distanceAlert:IsEnabled() then
                    self.distanceAlert:DisableAlert()
                end
            end
        end
    end
end
