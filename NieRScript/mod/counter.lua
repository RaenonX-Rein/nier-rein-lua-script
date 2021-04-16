--region Imports
configs = require(scriptPath() .. "mod/configs")
logger = require(scriptPath() .. "mod/logger")
--endregion

local counter = {}

local count_pass = 0
local count_fail = 0
local counter_lock = true

local csv_stream = io.open(scriptPath() .. configs.get_status_file_name() .. ".csv", "a+")

--region Accessors
function counter.get_count_pass()
    return count_pass
end

function counter.get_count_fail()
    return count_fail
end

function counter.get_count_total()
    return count_pass + count_fail
end

function counter.get_pass_pct()
    return count_pass / (count_pass + count_fail) * 100
end
--endregion

--region Utils
function counter.unlock()
    counter_lock = false
end

function counter.count_pass()
    if counter_lock then
        return false
    end
    count_pass = count_pass + 1
    logger.log_message(string.format(
            "Passed Once. New Counter Status: %s",
            counter.get_formatted_text()
    ))
    log_csv(true)
    counter_lock = true
    return true
end

function counter.count_fail()
    if not counter_lock then
        count_fail = count_fail + 1
        logger.log_message(string.format(
                "Failed Once. New Counter Status: %s",
                counter.get_formatted_text()
        ))
        log_csv(false)
    end
    counter_lock = true
end

function counter.get_formatted_text()
    return string.format("%s / %s (%.2f%%)",
            counter.get_count_pass(),
            counter.get_count_total(),
            counter.get_pass_pct()
    )
end

---log_csv
---
---Log a csv entry for stats.
---
---Only logs "0,1" (Failed) or "1,1" (Passed) so that the stats does not limited in a single run.
---
---@param passed boolean if the quest is passed
function log_csv(passed)
    if passed then
        csv_stream:write(string.format("%s,1,1\n", os.date("%Y-%m-%d %H:%M:%S")))
    else
        csv_stream:write(string.format("%s,0,1\n", os.date("%Y-%m-%d %H:%M:%S")))
    end
end
--endregion

return counter