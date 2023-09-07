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
    self:Hide()
    return self
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
