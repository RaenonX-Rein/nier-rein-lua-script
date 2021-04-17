--region Imports
configs = require(scriptPath() .. "mod/configs")
logger = require(scriptPath() .. "mod/logger")
--endregion

local counter = {}

local counter_local = {}
local counter_lock = true

--region Accessors
function counter.get_count_pass()
    return counter_local.count_pass
end

function counter.get_count_fail()
    return counter_local.count_fail
end

function counter.get_count_total()
    return counter_local.count_pass + counter_local.count_fail
end

function counter.get_pass_pct()
    return counter_local.count_pass / (counter_local.count_pass + counter_local.count_fail) * 100
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
    counter_local.count_pass = counter_local.count_pass + 1
    update_file()

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
        counter_local.count_fail = counter_local.count_fail + 1
        update_file()

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

function counter.reset()
    counter_local.count_pass = 0
    counter_local.count_fail = 0
    update_file()
end

---log_csv
---
---Log a csv entry for stats.
---
---Only logs "0,1" (Failed) or "1,1" (Passed) so that the stats does not limited in a single run.
---
---@param passed boolean if the quest is passed
function log_csv(passed)
    local csv_stream = io.open(scriptPath() .. configs.get_status_file_name() .. ".csv", "a+")

    if passed then
        csv_stream:write(string.format("%s,1,1\n", os.date("%Y-%m-%d %H:%M:%S")))
    else
        csv_stream:write(string.format("%s,0,1\n", os.date("%Y-%m-%d %H:%M:%S")))
    end

    csv_stream:close()
end
--endregion

--region Storage
function load_storage()
    if configs.reset_counter then
        counter.reset()
        return
    end

    local storage_stream = io.open(scriptPath() .. "counter.txt", "r")

    if storage_stream == nil then
        counter.reset()
    end

    local storage_content = storage_stream:read("*all")
    storage_stream:close()

    for k, v in string.gmatch(storage_content, "([%w_]+)=([%w_]+)") do
        counter_local[k] = tonumber(v)
    end
end

function update_file()
    local content = ""
    for k, v in pairs(counter_local) do
        content = content .. string.format("%s=%s\n", k, v)
    end

    local storage_stream = io.open(scriptPath() .. "counter.txt", "w+")
    storage_stream:write(content)
    storage_stream:close()
end
--endregion

load_storage()

return counter