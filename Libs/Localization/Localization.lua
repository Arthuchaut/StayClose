Localization = {}
Localization.__index = Localization

function Localization:GetWorldPosition(unitID)
    local x, y, _, mapID = UnitPosition(unitID)
    local facing = nil

    if unitID == "player" then
        facing = GetPlayerFacing()
    end

    return Position.New(x, y, mapID, facing)
end

function Localization:GetEuclideanDistance(positionA, positionB)
    return ((positionB.x - positionA.x)^2 + (positionB.y - positionA.y)^2)^0.5
end

function Localization:GetRelativeBearing(referencePosition, targetPosition)
    if not referencePosition.facing then
        error("Missing facing data for the referencePosition.")
    end
    
    local substractedVector2D = referencePosition:SubtractVector2D(targetPosition)
    local absoluteBearing = math.atan2(substractedVector2D.y, substractedVector2D.x) -- In radian
    local relativeBearing = math.deg(absoluteBearing - referencePosition.facing) % 360 -- In degree

    if relativeBearing < 0 then
        relativeBearing = 360 + relativeBearing
    end

    return relativeBearing
end
