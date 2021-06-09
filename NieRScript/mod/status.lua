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

status.QUEST_IN_GAME_PRE_WAVE_3 = "Quest / In-Game (Pre-wave 3)"
status.QUEST_IN_GAME_AT_WAVE_3 = "Quest / In-Game (Wave 3)"
status.QUEST_IN_GAME_SSR_DROPPED = "Quest / In-Game SSR (Dropped)"
status.QUEST_IN_GAME_ABORT_CONFIRM = "Quest / In-Game SSR (Abort)"
status.QUEST_IN_GAME_LOOP = "Quest / In-Game (Loop)"
status.QUEST_COMPLETE = "Quest / Complete"

status.QUEST_RESULT_LOOP = "Quest / Result (Loop)"
status.QUEST_RESULT_LOOP_DIALOG = "Quest / Result (Loop / Dialog)"

status.ARENA_MAIN = "Arena / Main"
status.ARENA_SELECT = "Arena / Select"
status.ARENA_BP_ITEM = "Arena / BP Fill"
status.ARENA_BP_CONFIRM_GEM = "Arena / BP Confirm (Gem)"
status.ARENA_BP_COMPLETE = "Arena / BP Complete"
status.ARENA_IN_BATTLE = "Arena / In battle"
status.ARENA_BATTLE_END = "Arena / End"

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

function status.initial_in_game()
    if configs.get_not_using_battery_save() then
        return status.QUEST_IN_GAME_PRE_WAVE_3
    end

    return status.QUEST_IN_GAME_LOOP
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
