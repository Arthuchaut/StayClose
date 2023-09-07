DefaultSettings = {
    static = {
        addOnName = "StayClose",
        frameUpdateInterval = 0.5, -- In seconds
        distanceAlertMessage = "Careful! You're too far away from {targetName} ({distance} yds).",
        instanceAlertMessage = "You're not in the same instance than {targetName}!",
        alertMessageColor = { 1, 0, 0, 1 }, -- RGBA
    },
    mutable = {
        minSafetyDistance = 20, -- In yards
        distanceWatcherEnabled = true,
        targetID = "player",
    }
}
