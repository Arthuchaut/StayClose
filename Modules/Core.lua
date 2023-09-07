Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    self.playerPosition = nil
    self.targetPosition = nil
    self.distanceAlertEnabled = false
    self.instanceAlertEnabled = false
    self.distanceMessageFrame = MessageFrame.New(
        GetScreenWidth(),
        GetScreenHeight(),
        StayCloseSettings.static.distanceAlert.x,
        StayCloseSettings.static.distanceAlert.y,
        StayCloseSettings.static.distanceAlert.fontSize,
        StayCloseSettings.static.distanceAlert.fontColor
    )
    self.instanceMessageFrame = MessageFrame.New(
        GetScreenWidth(),
        GetScreenHeight(),
        StayCloseSettings.static.instanceAlert.x,
        StayCloseSettings.static.instanceAlert.y,
        StayCloseSettings.static.instanceAlert.fontSize,
        StayCloseSettings.static.instanceAlert.fontColor
    )
    self.bearingArrowFrame = TextureFrame.New(
        StayCloseSettings.static.bearingArrow.width,
        StayCloseSettings.static.bearingArrow.height,
        StayCloseSettings.static.bearingArrow.x,
        StayCloseSettings.static.bearingArrow.y,
        StayCloseSettings.static.bearingArrow.textureFile,
        StayCloseSettings.static.bearingArrow.textureColor
    )
    return self
end

function Core:EnableDistanceAlertMessage()
    self.distanceAlertEnabled = true
    self.distanceMessageFrame:Show()
    self.bearingArrowFrame:Show()
end

function Core:UpdateBearingInfo(bearing)
    local g = math.abs(bearing - 180) / 180
    local r = 1 - g
    self.bearingArrowFrame:SetColor(r, g, 0, 1)
    self.bearingArrowFrame:Rotate(bearing)
end

function Core:UpdateDistanceInfo(playerDistanceFromTarget)
    self.distanceMessageFrame:SetMessage(
        Utils.FormatString(
            StayCloseSettings.static.distanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.mutable.targetID),
                distance = math.floor(playerDistanceFromTarget)
            }
        )
    )
end

function Core:DisableDistanceAlertMessage()
    self.distanceAlertEnabled = false
    self.distanceMessageFrame:Hide()
    self.bearingArrowFrame:Hide()
end

function Core:EnableInstanceAlertMessage()
    self.instanceAlertEnabled = true
    self.instanceMessageFrame:SetMessage(
        Utils.FormatString(
            StayCloseSettings.static.instanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.mutable.targetID),
            }
        )
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

                if playerDistanceFromTarget >= StayCloseSettings.mutable.safetyRadius then
                    local playerBearing = Localization:GetRelativeBearing(self.playerPosition, self.targetPosition)
                    self:UpdateDistanceInfo(playerDistanceFromTarget)
                    self:UpdateBearingInfo(playerBearing)

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
