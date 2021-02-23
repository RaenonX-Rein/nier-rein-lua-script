--region Imports
logger = require(scriptPath() .. "mod/logger")
configs = require(scriptPath() .. "mod/configs")
--endregion

local status = {}

--region States
status.UNKNOWN = "Unknown"

status.QUEST_SELECT = "Quest / Select"
status.QUEST_READY = "Quest / Ready"
status.QUEST_READY_INSUFFICIENT = "Quest / Ready (Insufficient)"

status.QUEST_IN_GAME_LOOP = "Quest / In-Game (Loop)"
status.QUEST_COMPLETE = "Quest / Complete"

status.QUEST_RESULT_LOOP = "Quest / Result (Loop)"
status.QUEST_RESULT_SINGLE = "Quest / Result (Single)"

status.FILL_AP_ITEM = "Fill / Item"
status.FILL_AP_CONFIRM = "Fill / Confirm"
status.FILL_AP_FILLED = "Fill / Filled"
--endregion

--region Functions
previous = status.UNKNOWN
current = status.UNKNOWN

function status.get_current()
    return current
end

function status.get_previous()
    return previous
end

function status.update(new_state)
    if configs.log_status then
        logger.log_message(string.format("Status [%s] > [%s]", current, new_state))
    end

    previous = current
    current = new_state
end
--endregion

return status
