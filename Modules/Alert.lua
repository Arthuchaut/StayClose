local BaseAlert = {}
BaseAlert.__index = BaseAlert

function BaseAlert.New(
    frameWidth,
    frameHeight,
    frameX,
    frameY,
    messageFontSize,
    messageFontColor
)
    local self = setmetatable({}, BaseAlert)
    self.messageFrame = MessageFrame.New(
        frameWidth,
        frameHeight,
        frameX,
        frameY,
        messageFontSize,
        messageFontColor
    )
    self.alertEnabled = false
    return self
end

function BaseAlert:IsEnabled()
    return self.alertEnabled
end

function BaseAlert:EnableAlert(message)
    self.alertEnabled = true
    self.messageFrame:SetMessage(message)
    self.messageFrame:Show()
end

function BaseAlert:DisableAlert()
    self.alertEnabled = false
    self.messageFrame:Hide()
end

DistanceAlert = setmetatable({}, BaseAlert)
DistanceAlert.__index = DistanceAlert

function DistanceAlert.New()
    local self = setmetatable(
        BaseAlert.New(
            GetScreenWidth(),
            GetScreenHeight(),
            StayCloseSettings.interface.distanceAlert.x,
            StayCloseSettings.interface.distanceAlert.y,
            StayCloseSettings.interface.distanceAlert.fontSize,
            StayCloseSettings.interface.distanceAlert.fontColor
        ),
        DistanceAlert
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

function DistanceAlert:EnableAlert()
    BaseAlert.EnableAlert(
        self,
        Utils.FormatString(
            StayCloseSettings.interface.distanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.core.targetID),
                distance = "N/A",
            }
        )
    )
    PlaySoundFile(StayCloseSettings.sound.distanceAlert.file)
    self.bearingArrowFrame:Show()
end

function DistanceAlert:DisableAlert()
    BaseAlert.DisableAlert(self)
    self.bearingArrowFrame:Hide()
end

function DistanceAlert:UpdateBearingInfo(bearing)
    local g = math.abs(bearing - 180) / 180
    local r = 1 - g
    self.bearingArrowFrame:SetColor(r, g, 0, 1)
    self.bearingArrowFrame:Rotate(bearing)
end

function DistanceAlert:UpdateDistanceInfo(distance)
    self.messageFrame:SetMessage(
        Utils.FormatString(
            StayCloseSettings.interface.distanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.core.targetID),
                distance = math.floor(distance)
            }
        )
    )
end

InstanceAlert = setmetatable({}, BaseAlert)
InstanceAlert.__index = InstanceAlert

function InstanceAlert.New()
    local self = setmetatable(
        BaseAlert.New(
            GetScreenWidth(),
            GetScreenHeight(),
            StayCloseSettings.interface.instanceAlert.x,
            StayCloseSettings.interface.instanceAlert.y,
            StayCloseSettings.interface.instanceAlert.fontSize,
            StayCloseSettings.interface.instanceAlert.fontColor
        ),
        InstanceAlert
    )
    return self
end

function InstanceAlert:EnableAlert()
    BaseAlert.EnableAlert(
        self,
        Utils.FormatString(
            StayCloseSettings.interface.instanceAlert.message,
            {
                targetName = Utils.GetUnitName(StayCloseSettings.core.targetID),
            }
        )
    )
    PlaySoundFile(StayCloseSettings.sound.instanceAlert.file)
end
