Initializer = {}
Initializer.__index = Initializer

function Initializer.LoadAddOn(cls, callbackObjectReference, callback)
    local elapsedTime = 0
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, addOnName)
        if event == "ADDON_LOADED" and addOnName == defaultSettings.global.addOnName then
            if not StayCloseSettings or next(StayCloseSettings) == nil then
                StayCloseSettings = defaultSettings
            end

            frame:SetScript("OnUpdate", function(_, deltaTime)
                elapsedTime = elapsedTime + deltaTime

                if elapsedTime >= StayCloseSettings.global.frameUpdateInterval then
                    callback(callbackObjectReference)
                    elapsedTime = 0
                end
            end)
        end
    end)
end