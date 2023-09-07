Utils = {}
Utils.__index = Utils

function Utils.FormatString(str, vars)
    return (str:gsub("(%b{})", function(word)
        return vars[word:sub(2, -2)] or word
    end))
end

function Utils.GetUnitName(unitID)
    if not UnitExists(unitID) then
        return "Unknown"
    end

    return UnitName(unitID)
end

function Utils.NormalizeRGBA(r, g, b, a)
    return { r / 255, g / 255, b / 255, a / 255 }
end
