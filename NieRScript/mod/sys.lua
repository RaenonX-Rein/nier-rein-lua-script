--region Imports
configs = require(scriptPath() .. "mod/configs")
counter = require(scriptPath() .. "mod/counter")
status = require(scriptPath() .. "mod/status")
--endregion

local system = {}

local begin_t = Timer()

--region Script termination
function system.update_stop_message(message)
    if not message then
        message = "N/A"
    end

    local t = begin_t:check()
    local avg = t / counter.get_count_pass()

    setStopMessage(string.format(
            "Message: %s\nElapsed: %.3f s\nRuns: %s\nAverage %.3f s / Pass\n\nCurrent Status: %s\nPrevious Status: %s",
            message, t, counter.get_formatted_text(), avg, status.get_current(), status.get_previous()
    ))
end

function system.terminate(message)
    system.update_stop_message(message)
    scriptExit(message)
end

function system.check_games()
    if counter.get_count_pass() >= configs.total_games then
        system.terminate(string.format("Target games (%d) reached.", counter.get_count_pass()))
    end
end
--endregion

--region Toast
local last_toast = Timer()

-----generate_toast
-----
-----Update the stop message and display a toast if the CD is completed.
function system.generate_toast()
    system.update_stop_message()

    local toast_enabled = configs.toast_enable
    local cd_completed = last_toast:check() > configs.toast_cd_sec

    if toast_enabled and cd_completed then
        local t = begin_t:check()
        local avg = t / counter.get_count_pass()

        toast(string.format(
                "%.3f s @ %s (%s, %.3f)", t, status.get_current(), counter.get_formatted_text(), avg
        ))

        last_toast:set()
    end
end
--endregion

return system
