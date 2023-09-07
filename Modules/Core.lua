Core = {}
Core.__index = Core

function Core.New()
    local self = setmetatable({}, Core)
    self.distanceAlertEnabled = false
    self.instanceAlertEnabled = false
    self.distanceMessageFrame = MessageFrame.New(
        GetScreenWidth(),
        GetScreenHeight(),
        StayCloseSettings.interface.distanceAlert.x,
        StayCloseSettings.interface.distanceAlert.y,
        StayCloseSettings.interface.distanceAlert.fontSize,
        StayCloseSettings.interface.distanceAlert.fontColor
    )
    self.instanceMessageFrame = MessageFrame.New(
        GetScreenWidth(),
        GetScreenHeight(),
        StayCloseSettings.interface.instanceAlert.x,
        StayCloseSettings.interface.instanceAlert.y,
        StayCloseSettings.interface.instanceAlert.fontSize,
        StayCloseSettings.interface.instanceAlert.fontColor
    )
    self.bearingArrowFrame = TextureFrame.New(
        StayCloseSettings.interface.bearingArrow.width,
        StayCloseSettings.interface.bearingArrow.height,
        StayCloseSettings.interface.bearingArrow.x,
        StayCloseSettings.interface.bearingArrow.y,
        StayCloseSettings.interface.bearingArrow.textureFile,
        StayCloseSettings.interface.bearingArrow.textureColor
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
            StayCloseSettings.interface.distanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.core.targetID),
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
            StayCloseSettings.interface.instanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.core.targetID),
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
    if StayCloseSettings.core.distanceWatcherEnabled then
        local playerPosition = Localization:GetWorldPosition("player")

        if UnitExists(StayCloseSettings.core.targetID) then
            -- targetPosition = Localization:GetWorldPosition(StayCloseSettings.core.targetID)
            local targetPosition = Position.New(-8825, 634, 0) -- The place near the auction house in Stomwind

            if playerPosition.mapID ~= targetPosition.mapID then
                if not self.instanceAlertEnabled then
                    self:EnableInstanceAlertMessage()
                end
            elseif self.instanceAlertEnabled then
                self:DisableInstanceAlertMessage()
            else
                local playerDistanceFromTarget = Localization:GetEuclideanDistance(playerPosition,
                    targetPosition)

                if playerDistanceFromTarget >= StayCloseSettings.core.safetyRadius then
                    local playerBearing = Localization:GetRelativeBearing(playerPosition, targetPosition)
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
