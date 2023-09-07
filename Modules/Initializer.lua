Initializer = {}
Initializer.__index = Initializer

function Initializer.LoadAddOn()
    local elapsedTime = 0
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(_, event, addOnName)
        if event == "ADDON_LOADED" and addOnName == DefaultSettings.core.addOnName then
            if not StayCloseSettings or next(StayCloseSettings) == nil or DefaultSettings.core.debugMode then
                StayCloseSettings = DefaultSettings
            end

            local core = Core.New()
            frame:SetScript("OnUpdate", function(_, deltaTime)
                elapsedTime = elapsedTime + deltaTime

                if elapsedTime >= StayCloseSettings.core.frameUpdateInterval then
                    core:UpdateFrame()
                    elapsedTime = 0
                end
            end)
        end
    end)
end
