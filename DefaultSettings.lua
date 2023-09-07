DefaultSettings = {
    core = {
        addOnName = "StayClose",
        distanceWatcherEnabled = true,
        frameUpdateInterval = 0.02, -- In seconds
        safetyRadius = 20,          -- In yards
        targetID = "player",
        debugMode = true,
    },
    sound = {
        distanceAlert = {
            file = "Interface\\AddOns\\StayClose\\Sounds\\AmongUs.ogg",
        },
        instanceAlert = {
            file = "Interface\\AddOns\\StayClose\\Sounds\\MipMipPew.ogg",
        },
    },
    interface = {
        distanceAlert = {
            message = "Careful! You're too far away from {targetName} ({distance} yds).",
            fontSize = 30,
            fontColor = Utils.NormalizeRGBA(255, 0, 0, 255), -- RGBA
            x = 0,
            y = 0,
        },
        instanceAlert = {
            message = "You're not in the same instance than {targetName}!",
            fontSize = 30,
            fontColor = Utils.NormalizeRGBA(255, 120, 0, 255), -- RGBA
            x = 0,
            y = 0,
        },
        bearingArrow = {
            width = 50,
            height = 50,
            x = 0,
            y = -100,
            textureFile = "Interface\\AddOns\\StayClose\\Textures\\Arrow.tga",
            textureColor = Utils.NormalizeRGBA(255, 0, 0, 255), -- RGBA
        },
    },
}
