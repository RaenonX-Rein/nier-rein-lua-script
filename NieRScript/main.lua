--region Imports
action = require(scriptPath() .. "mod/action")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

while true do
    local current_status = status.get_current()

    if current_status == status.QUEST_SELECT then
        action.quest_select_quest()
    elseif current_status == status.QUEST_READY then
        action.quest_start_quest()
    elseif current_status == status.QUEST_IN_GAME_LOOP then
        action.quest_close_menu()
        action.quest_check_complete()
        action.quest_wait_result_loop()
    elseif current_status == status.QUEST_COMPLETE then
        action.quest_wait_in_game_loop()
    elseif current_status == status.QUEST_RESULT_LOOP then
        action.quest_check_result_loop()
    elseif current_status == status.QUEST_RESULT_SINGLE then
        action.quest_check_result_single()
    elseif current_status == status.QUEST_READY_INSUFFICIENT then
        action.fill_ap()
    elseif current_status == status.FILL_AP_ITEM then
        action.fill_ap_select_item()
    elseif current_status == status.FILL_AP_CONFIRM then
        action.fill_ap_confirm()
    elseif current_status == status.FILL_AP_FILLED then
        action.fill_check_filled()
    elseif current_status == status.UNKNOWN then
        action.quest_select_quest()  -- Detect quest menu
        action.quest_start_quest()  -- Detect in-game or insufficient AP
    else
        sys.terminate(string.format("Unhandled state: %s\nScript terminated.", current_status))
    end

    sys.generate_toast()
    sys.check_games()
end
