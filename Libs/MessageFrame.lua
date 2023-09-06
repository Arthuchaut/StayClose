MessageFrame = {}
MessageFrame.__index = MessageFrame

function MessageFrame.New(width, height, x, y)
    local self = setmetatable({}, MessageFrame)
    self._x = x or nil
    self._y = y or nil
    self.frame = CreateFrame("Frame", nil, UIParent)
    self.frame:SetSize(width, height)
    self.frame:SetPoint("CENTER", UIParent, "CENTER", self._x, self._y)
    self.messageText = self.frame:CreateFontString(nil, "OVERLAY")
    self.messageText:SetAllPoints(self.frame)
    self.messageText:SetFont("Fonts\\FRIZQT__.TTF", 30, "OUTLINE")
    return self
end

function MessageFrame:SetMessage(msg, ...)
    self.messageText:SetTextColor(...)
    self.messageText:SetText(msg)
end

function MessageFrame:Show()
    self.frame:Show()
end

function MessageFrame:Hide()
    self.frame:Hide()
end