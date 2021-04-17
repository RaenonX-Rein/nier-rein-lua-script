--region Imports
configs = require(scriptPath() .. "mod/configs")
status = require(scriptPath() .. "mod/status")
--endregion

local base = {}

function base.random_click(loc, rand_offset)
    local x = math.random(loc:getX() - rand_offset, loc:getX() + rand_offset)
    local y = math.random(loc:getY() - rand_offset, loc:getY() + rand_offset)

    click(Location(x, y))
    if configs.log_random_click then
        logger.log_message(string.format("Clicked on (%d, %d)", x, y))
    end
end

---click_delay
---Click on ``location`` and then wait for ``delay`` seconds.
---
---@param location Location location to be clicked
---@param delay number seconds to wait
function base.click_delay(location, delay)
    if configs.random_click then
        base.random_click(location, configs.random_click_offset)
    else
        click(location)
    end

    if delay == nil then
        delay = configs.default_click_delay
    end
    wait(delay)
end

---check_image
---
---Check the image in the ``region`` with the image at ``path``.
---
---If found, update the status to be the ``new_status`` and execute ``true_func``.
---
---@param image_obj table `table` containing the image path and region to check
---@param new_status string new status if image found and this parameter is provided (not nil)
---@param true_func function function to execute if image found
---@return boolean if the image was found
function base.check_image(image_obj, new_status, true_func)
    if configs.debug then
        image_obj.region:highlight()
    end

    local found = false
    for _, m in ipairs(regionFindAllNoFindException(image_obj.region, image_obj.path)) do
        found = true

        if new_status ~= nil then
            status.update(new_status)
        end

        if true_func ~= nil then
            true_func(m)
            break
        end
    end

    if configs.debug then
        image_obj.region:highlight()
    end

    return found
end

---Check the image existence.
---
---If the image is not found, swipe up from a specific point to another specific point.
function base.check_image_swipe_up(image_obj, swipe_loc_1, swipe_loc_2, new_status, true_func)
    if base.check_image(image_obj, new_status, true_func) then
        return true  -- Desired image found
    end

    setDragDropTiming(50, 50)  -- Press & hold for 50 ms; hold for 50 ms before release
    setDragDropStepCount(30)  -- Moving step count
    setDragDropStepInterval(10)  -- Step changing interval in ms

    dragDrop(swipe_loc_1, swipe_loc_2)
    wait(configs.default_drag_drop_delay)  -- Wait for animation to recover
    return false
end

return base