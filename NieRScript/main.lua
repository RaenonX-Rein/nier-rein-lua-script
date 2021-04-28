--region Imports
action = require(scriptPath() .. "mod/action")
configs = require(scriptPath() .. "mod/configs")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

Settings:set("MinSimilarity", configs.min_similarity)
-- Enables the control in the navbar area
setImmersiveMode(true)

while true do
    local current_status = status.get_current()

    if current_status == status.QUEST_SELECT then
        action.quest_select_quest()
    elseif current_status == status.QUEST_READY then
        action.quest_start_quest()
    elseif current_status == status.QUEST_IN_GAME_LOOP then
        action.quest_close_menu()
        action.quest_check_single_loop_complete()
        action.quest_wait_result_loop()
    elseif current_status == status.QUEST_IN_GAME_PRE_WAVE_3 then
        action.quest_close_menu()
        action.quest_check_into_wave_3()
    elseif current_status == status.QUEST_IN_GAME_AT_WAVE_3 then
        action.quest_handle_at_wave_3()
    elseif current_status == status.QUEST_IN_GAME_SSR_DROPPED then
        action.quest_check_complete_ssr_dropped()
    elseif current_status == status.QUEST_IN_GAME_ABORT_CONFIRM then
        action.quest_confirm_abort()
    elseif current_status == status.QUEST_COMPLETE then
        action.quest_wait_in_game_loop()
    elseif current_status == status.QUEST_RESULT_LOOP_DIALOG then
        action.quest_check_loop_result_dialog()
    elseif current_status == status.QUEST_RESULT_LOOP then
        action.quest_check_loop_result()
        action.quest_start_quest(false)
    elseif current_status == status.QUEST_RESULT_LOOP_SINGLE then
        action.quest_check_result_loop_single()
    elseif current_status == status.QUEST_READY_INSUFFICIENT then
        action.fill_ap()
    elseif current_status == status.FILL_AP_ITEM then
        action.fill_ap_select_item()
    elseif current_status == status.FILL_AP_CONFIRM then
        action.fill_ap_confirm()
    elseif current_status == status.FILL_AP_FILLED then
        action.fill_check_filled()
        action.quest_start_quest()
    elseif current_status == status.UNKNOWN then
        action.quest_select_quest()  -- Detect quest menu
        action.quest_start_quest(false)  -- Detect in-game or insufficient AP
    else
        sys.terminate(string.format("Unhandled state: %s\nScript terminated.", current_status))
    end

    sys.generate_toast()
    sys.check_games()
end
