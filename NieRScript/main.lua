--region Imports
action_arena = require(scriptPath() .. "mod/action_arena")
action_quest = require(scriptPath() .. "mod/action_quest")
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
        action_quest.quest_select_quest()
    elseif current_status == status.QUEST_READY then
        action_quest.quest_start_quest()
    elseif current_status == status.QUEST_IN_GAME_LOOP then
        action_quest.quest_close_menu()
        action_quest.quest_check_single_loop_complete()
        action_quest.quest_wait_result_loop()
    elseif current_status == status.QUEST_IN_GAME_PRE_WAVE_3 then
        action_quest.quest_close_menu()
        action_quest.quest_check_into_wave_3()
    elseif current_status == status.QUEST_IN_GAME_AT_WAVE_3 then
        action_quest.quest_handle_at_wave_3()
    elseif current_status == status.QUEST_IN_GAME_SSR_DROPPED then
        action_quest.quest_check_complete_ssr_dropped()
    elseif current_status == status.QUEST_IN_GAME_ABORT_CONFIRM then
        action_quest.quest_confirm_abort()
    elseif current_status == status.QUEST_COMPLETE then
        action_quest.quest_wait_in_game_loop()
    elseif current_status == status.QUEST_RESULT_LOOP_DIALOG then
        action_quest.quest_check_loop_result_dialog()
    elseif current_status == status.QUEST_RESULT_LOOP then
        action_quest.quest_check_loop_result()
        action_quest.quest_start_quest(false)
    elseif current_status == status.QUEST_RESULT_LOOP_SINGLE then
        action_quest.quest_check_result_loop_single()
    elseif current_status == status.QUEST_READY_INSUFFICIENT then
        action_quest.fill_ap()
    elseif current_status == status.ARENA_MAIN then
        action_arena.arena_open_menu()
    elseif current_status == status.ARENA_SELECT then
        action_arena.arena_start_battle()
    elseif current_status == status.ARENA_BP_ITEM then
        action_arena.arena_bp_fill_item()
    elseif current_status == status.ARENA_BP_CONFIRM_GEM then
        action_arena.arena_bp_fill_confirm_gems()
    elseif current_status == status.ARENA_BP_COMPLETE then
        action_arena.arena_bp_fill_dismiss_dialog()
    elseif current_status == status.ARENA_IN_BATTLE then
        action_arena.arena_in_battle()
    elseif current_status == status.ARENA_BATTLE_END then
        action_arena.arena_battle_end()
    elseif current_status == status.FILL_AP_ITEM then
        action_quest.fill_ap_select_item()
    elseif current_status == status.FILL_AP_CONFIRM then
        action_quest.fill_ap_confirm()
    elseif current_status == status.FILL_AP_FILLED then
        action_quest.fill_check_filled()
        action_quest.quest_start_quest()
    elseif current_status == status.UNKNOWN then
        if configs.quest_select == "Arena" then
            action_arena.arena_open_menu()  -- Detect arena main screen
            action_arena.arena_start_battle()  -- Detect arena start battle
            action_arena.arena_in_battle()  -- Detect arena in-game (just ends)
        else
            action_quest.quest_select_quest()  -- Detect quest menu
            action_quest.quest_start_quest(false)  -- Detect in-game or insufficient AP
        end
    else
        sys.terminate(string.format("Unhandled state: %s\nScript terminated.", current_status))
    end

    sys.generate_toast()
    sys.check_games()
end
