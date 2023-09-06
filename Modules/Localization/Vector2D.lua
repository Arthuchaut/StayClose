Vector2D = {}
Vector2D.__index = Vector2D

function Vector2D.New(x, y)
    local self = setmetatable({}, Vector2D)
    self.x = x
    self.y = y
    return self
end

function Vector2D:SubtractVector2D(other)
    return Vector2D.New(other.x - self.x, other.y - self.y) 
end