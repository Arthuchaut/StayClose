Position = setmetatable({}, Vector2D)
Position.__index = Position

function Position.New(x, y, mapID, facing)
    local self = setmetatable(Vector2D.New(x, y), Position)
    self.mapID = mapID or 0
    self.facing = facing or nil
    return self
end

function Position:GetXY()
    return self.x, self.y
end