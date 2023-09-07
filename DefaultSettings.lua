DefaultSettings = {
    static = {
        addOnName = "StayClose",
        frameUpdateInterval = 0.02, -- In seconds
        distanceAlert = {
            message = "Careful! You're too far away from {targetName} ({distance} yds).",
            fontSize = 30,
            fontColor = { 1, 0, 0, 1 }, -- RGBA
            x = 0,
            y = 0,
        },
        instanceAlert = {
            message = "You're not in the same instance than {targetName}!",
            fontSize = 30,
            fontColor = { 1, 0, 0, 1 }, -- RGBA
            x = 0,
            y = 0,
        },
        bearingArrow = {
            width = 50,
            height = 50,
            x = 0,
            y = -100,
            textureFile = "Interface\\AddOns\\StayClose\\Textures\\Arrow.tga",
            textureColor = { 1, 0, 0, 1 }, -- RGBA
        }
    },
    mutable = {
        safetyRadius = 20, -- In yards
        distanceWatcherEnabled = true,
        targetID = "player",
    }
}
