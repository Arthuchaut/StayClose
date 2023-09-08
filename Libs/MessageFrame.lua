MessageFrame = {}
MessageFrame.__index = MessageFrame

function MessageFrame.New(width, height, x, y, fontSize, fontColor)
    local self = setmetatable({}, MessageFrame)
    self.frame = CreateFrame("Frame", nil, UIParent)
    self.frame:SetSize(width, height)
    self.frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
    self.messageText = self.frame:CreateFontString(nil, "OVERLAY")
    self.messageText:SetAllPoints(self.frame)
    self.messageText:SetTextColor(unpack(fontColor))
    self.messageText:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
    self.bounceAnim = self:InitBounceAnimation()
    self:Hide()
    return self
end

function MessageFrame:InitBounceAnimation()
    local animGroup = self.frame:CreateAnimationGroup()
    local bounceUp = animGroup:CreateAnimation("Translation")
    local bounceDown = animGroup:CreateAnimation("Translation")
    bounceUp:SetOffset(0, 5)
    bounceUp:SetDuration(0.2)
    bounceUp:SetOrder(1)
    bounceDown:SetOffset(0, -5)
    bounceDown:SetDuration(0.2)
    bounceDown:SetOrder(2)
    return animGroup
end

function MessageFrame:StartBouncing()
    self.bounceAnim:Play()
    self.bounceAnim:SetLooping("REPEAT")
end

function MessageFrame:StopBouncing()
    self.bounceAnim:Stop()
end

function MessageFrame:SetMessage(msg)
    self.messageText:SetText(msg)
end

function MessageFrame:Show()
    self.frame:Show()
end

function MessageFrame:Hide()
    self.frame:Hide()
end
