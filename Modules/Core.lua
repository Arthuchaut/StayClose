Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    self.playerPosition = nil
    self.targetPosition = nil
    self.distanceAlertEnabled = false
    self.instanceAlertEnabled = false
    self.distanceMessageFrame = MessageFrame.New(GetScreenWidth(), GetScreenHeight())
    self.instanceMessageFrame = MessageFrame.New(GetScreenWidth(), GetScreenHeight())
    return self
end

function Core:EnableDistanceAlertMessage()
    self.distanceAlertEnabled = true
    self.distanceMessageFrame:Show()
end

function Core:UpdateBearingInfo()

end

function Core:UpdateDistanceInfo(playerDistanceFromTarget)
    self.distanceMessageFrame:SetMessage(
        Utils.FormatString(
            StayCloseSettings.static.distanceAlertMessage,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.mutable.targetID),
                distance = math.floor(playerDistanceFromTarget)
            }
        ),
        unpack(StayCloseSettings.static.alertMessageColor)
    )
end

function Core:DisableDistanceAlertMessage()
    self.distanceAlertEnabled = false
    self.distanceMessageFrame:Hide()
end

function Core:EnableInstanceAlertMessage()
    self.instanceAlertEnabled = true
    self.instanceMessageFrame:SetMessage(
        Utils.FormatString(
            StayCloseSettings.static.instanceAlertMessage,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.mutable.targetID),
            }
        ),
        unpack(StayCloseSettings.static.alertMessageColor)
    )
    self.instanceMessageFrame:Show()
end

function Core:DisableInstanceAlertMessage()
    self.instanceAlertEnabled = false
    self.instanceMessageFrame:Hide()
end

function Core:UpdateFrame()
    if StayCloseSettings.mutable.distanceWatcherEnabled then
        self.playerPosition = Localization:GetWorldPosition("player")

        if UnitExists(StayCloseSettings.mutable.targetID) then
            -- self.targetPosition = Localization:GetWorldPosition(StayCloseSettings.mutable.targetID)
            self.targetPosition = Position.New(-8825, 634, 0) -- The place near the auction house in Stomwind

            if self.playerPosition.mapID ~= self.targetPosition.mapID then
                if not self.instanceAlertEnabled then
                    self:EnableInstanceAlertMessage()
                end
            elseif self.instanceAlertEnabled then
                self:DisableInstanceAlertMessage()
            else
                local playerDistanceFromTarget = Localization:GetEuclideanDistance(self.playerPosition,
                    self.targetPosition)

                if playerDistanceFromTarget >= StayCloseSettings.mutable.minSafetyDistance then
                    local playerBearing = Localization:GetRelativeBearing(self.playerPosition, self.targetPosition)
                    self:UpdateDistanceInfo(playerDistanceFromTarget)
                    self:UpdateBearingInfo()

                    if not self.distanceAlertEnabled then
                        self:EnableDistanceAlertMessage()
                    end
                elseif self.distanceAlertEnabled then
                    self:DisableDistanceAlertMessage()
                end
            end
        end
    end
end

function Core:Run()
    Initializer:LoadAddOn(self, self.UpdateFrame)
end
