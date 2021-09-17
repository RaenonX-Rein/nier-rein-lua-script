local utils = {}

local size_app = getAppUsableScreenSize()
local size_real = getRealScreenSize()

local ratio_x = size_app:getX() / size_real:getX()

---Auto-correct the region before actually using it.
---
---Because there are some bugs for the region auto-correction in AnkuLua (caused by navbar),
---if immersive mode on, the region to be used will be changed to the wrong one.
---In this case, we need to use this function to get the correct region to use,
---or the result will be incorrect.
function utils.correct_region(region)
    -- Compare by width so only multiply by X ratio
    return Region(
        region:getX() * ratio_x,
        region:getY() * ratio_x,
        region:getW() * ratio_x,
        region:getH() * ratio_x
    )
end

function utils.correct_location(location)
    -- Compare by width so only multiply by X ratio
    return Location(
        location:getX() * ratio_x,
        location:getY() * ratio_x
    )
end

function utils.init_table(value, count)
    local ret = {}
    for i = 1, count do
        ret[i] = value
    end

    return ret
end

function utils.starts_with(s, start)
    return string.sub(s, 1, string.len(start)) == start
end

return utils
