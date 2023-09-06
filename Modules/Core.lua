Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    self.playerPosition = nil
    self.targetPosition = nil
    self.playerDistanceFromTarget = nil
    self.playerBearing = nil
    self.distanceAlertEnabled = false
    self.instanceAlertEnabled = false
    return self
end

function Core:EnableDistanceAlertMessage()
    print("Distance alert enabled!", self.playerDistanceFromTarget)
end

function Core:UpdateBearingInfo()
    print("Bearing:", self.playerBearing)
end

function Core:DisableDistanceAlertMessage()
    print("Distance alert disabled.")
end

function Core:EnableInstanceAlertMessage()
    print("Instance alert inabled!")
end

function Core:DisableInstanceAlertMessage()
    print("Instance alert disabled.")
end

function Core:UpdateFrame()
    if StayCloseSettings.variable.distanceWatcherEnabled then
        self.playerPosition = Localization:GetWorldPosition("player")

        if UnitExists(StayCloseSettings.variable.targetID) then
            -- self.targetPosition = Localization:GetWorldPosition(StayCloseSettings.variable.targetID)
            self.targetPosition = Position.New(-8825, 634, 0) -- The place near the auction house in Stomwind

            if self.playerPosition.mapID ~= self.targetPosition.mapID then
                if not self.instanceAlertEnabled then
                    self.instanceAlertEnabled = true
                    self:EnableInstanceAlertMessage()
                end
            else
                if self.instanceAlertEnabled then
                    self.instanceAlertEnabled = false
                    self:DisableInstanceAlertMessage()
                end

                self.playerDistanceFromTarget = Localization:GetEuclideanDistance(self.playerPosition, self.targetPosition)

                if self.playerDistanceFromTarget >= StayCloseSettings.variable.minSafetyDistance then
                    self.playerBearing = Localization:GetRelativeBearing(self.playerPosition, self.targetPosition)
                    self:UpdateBearingInfo()

                    if not self.distanceAlertEnabled then
                        self.distanceAlertEnabled = true
                        self:EnableDistanceAlertMessage()
                    end
                elseif self.distanceAlertEnabled then
                    self.distanceAlertEnabled = false
                    self:DisableDistanceAlertMessage()
                end
            end
        end
    end
end

function Core:Run()
    Initializer:LoadAddOn(self, self.UpdateFrame)
end