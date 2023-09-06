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
    self.distanceMessageFrame:Show()
end

function Core:UpdateBearingInfo()
    self.distanceMessageFrame:SetMessage(
        string.format(
            "%s (%.f yd).",
            StayCloseSettings.static.distanceAlertMessage,
            self.playerBearing
        )
    )
end

function Core:UpdateDistanceInfo(playerDistanceFromTarget)
    self.distanceMessageFrame:SetMessage(
        string.format(
            "%s (%.f yd).",
            StayCloseSettings.static.distanceAlertMessage,
            playerDistanceFromTarget
        ),
        unpack(StayCloseSettings.static.alertMessageColor)
    )
end

function Core:DisableDistanceAlertMessage()
    self.distanceMessageFrame:Hide()
end

function Core:EnableInstanceAlertMessage()
    self.instanceMessageFrame:SetMessage("Instance alert enabled!", unpack(StayCloseSettings.static.alertMessageColor))
    -- self.instanceMessageFrame:Show()
end

function Core:DisableInstanceAlertMessage()
    self.instanceMessageFrame:Hide()
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

                local playerDistanceFromTarget = Localization:GetEuclideanDistance(self.playerPosition, self.targetPosition)

                if playerDistanceFromTarget >= StayCloseSettings.variable.minSafetyDistance then
                    local playerBearing = Localization:GetRelativeBearing(self.playerPosition, self.targetPosition)
                    self:UpdateDistanceInfo(playerDistanceFromTarget)

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