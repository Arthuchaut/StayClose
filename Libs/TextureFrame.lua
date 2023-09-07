TextureFrame = {}
TextureFrame.__index = TextureFrame

function TextureFrame.New(width, height, x, y, textureFile, textureColor)
    local self = setmetatable({}, TextureFrame)
    self.frame = CreateFrame("Frame", nil, UIParent)
    self.frame:SetSize(width, height)
    self.frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
    self.texture = self.frame:CreateTexture(nil, "BACKGROUND")
    self.texture:SetAllPoints(self.frame)
    self.texture:SetTexture(textureFile)
    self:SetColor(unpack(textureColor))
    self:Hide()
    return self
end

function TextureFrame:SetColor(r, g, b, a)
    self.texture:SetVertexColor(r, g, b, a)
end

function TextureFrame:Rotate(degree)
    self.texture:SetPoint("CENTER", self.frame, "CENTER")
    self.texture:SetRotation(math.rad(degree))
end

function TextureFrame:Show()
    self.frame:Show()
end

function TextureFrame:Hide()
    self.frame:Hide()
end
