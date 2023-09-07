Initializer = {}
Initializer.__index = Initializer

function Initializer.LoadAddOn()
    local elapsedTime = 0
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(_, event, addOnName)
        if event == "ADDON_LOADED" and addOnName == DefaultSettings.static.addOnName then
            if not StayCloseSettings or next(StayCloseSettings) == nil then
                StayCloseSettings = {
                    static = nil,
                    mutable = DefaultSettings.mutable,
                }
            end

            StayCloseSettings.static = DefaultSettings.static
            local core = Core.New()
            frame:SetScript("OnUpdate", function(_, deltaTime)
                elapsedTime = elapsedTime + deltaTime

                if elapsedTime >= StayCloseSettings.static.frameUpdateInterval then
                    core:UpdateFrame()
                    elapsedTime = 0
                end
            end)
        end
    end)
end
