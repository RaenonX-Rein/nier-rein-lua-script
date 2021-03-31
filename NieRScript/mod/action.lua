--region Imports
base = require(scriptPath() .. "mod/base")
coords = require(scriptPath() .. "mod/coords")
configs = require(scriptPath() .. "mod/configs")
counter = require(scriptPath() .. "mod/counter")
images = require(scriptPath() .. "mod/images")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

local action = {}

local function quest_dark_mem_swipe_up()
    if base.check_image(images.quest_dark_mem_2_coin_text) then
        return true  -- Found that the text for "coin" exists i.e. at the menu bottom
    end

    setDragDropTiming(50, 50)  -- Press & hold for 50 ms; hold for 50 ms before release
    setDragDropStepCount(30)  -- Moving step count
    setDragDropStepInterval(10)  -- Step changing interval in ms

    dragDrop(coords.quest_select_dark_mem_swipe_1, coords.quest_select_dark_mem_swipe_2)
    wait(1.0)  -- Wait for swipe animation recovery
    return false
end

local function quest_handle_event_vh(vh_image, vh_coords)
    if not base.check_image(images.quest_event_vh_difficulty_text) then
        -- Not very hard difficulty
        base.click_delay(coords.quest_select_event_difficulty)
        return
    end

    if not base.check_image(vh_image) then
        -- Is very hard difficulty & not found quest 10
        setDragDropTiming(50, 50)  -- Press & hold for 50 ms; hold for 50 ms before release
        setDragDropStepCount(30)  -- Moving step count
        setDragDropStepInterval(10)  -- Step changing interval in ms

        dragDrop(coords.quest_select_event_list_swipe_1, coords.quest_select_event_list_swipe_2)
        wait(0.5)  -- Wait for swipe animation recovery
        return
    end

    -- Found quest 10 and is very hard difficulty
    base.click_delay(vh_coords)
end

---Select the quest to auto if the current page is in quest selection menu.
function action.quest_select_quest()
    if base.check_image(images.quest_ready_indicator, status.QUEST_READY) then
        return  -- Found quest ready indicator, update the status and terminate
    end

    if not base.check_image(images.friend_icon) then
        -- Only perform checks and quest selection click if friend icon is detected
        -- This is because that clicking the quest may cause delays.

        -- If the quest ready screen is not loaded after the clicks,
        -- but readies right after the wait of the actions below,
        -- then the actions below will be wrongly performed and causes bugs
        return
    end

    if base.check_image(images.quest_wrong_indicator_pod) then
        -- Accidentally goes into pod edit page, go back
        base.click_delay(coords.quest_select_wrong_pod)
    end

    local quest_name = configs.quest_select

    if quest_name == "DarkMem/Ticket-1" then
        base.click_delay(coords.quest_select_dark_mem_ticket_1)
    elseif quest_name == "DarkMem/Coin-1" then
        base.click_delay(coords.quest_select_dark_mem_coin_1)
    elseif quest_name == "DarkMem/Ticket-2" then
        if not quest_dark_mem_swipe_up() then
            return
        end
        base.click_delay(coords.quest_select_dark_mem_ticket_2)
    elseif quest_name == "DarkMem/Coin-2" then
        if not quest_dark_mem_swipe_up() then
            return
        end
        base.click_delay(coords.quest_select_dark_mem_coin_2)
    elseif quest_name == "DarkMem/Std" then
        base.click_delay(coords.quest_select_dark_mem_std)
    elseif quest_name == "DarkMem/Exp" then
        base.click_delay(coords.quest_select_dark_mem_exp)
    elseif quest_name == "DarkMem/Mst" then
        base.click_delay(coords.quest_select_dark_mem_mst)
    elseif quest_name == "Main/1" then
        base.click_delay(coords.quest_select_main_1)
    elseif quest_name == "Main/4" then
        base.click_delay(coords.quest_select_main_4)
    elseif quest_name == "Main/6" then
        base.click_delay(coords.quest_select_main_6)
    elseif quest_name == "Main/7" then
        base.click_delay(coords.quest_select_main_7)
    elseif quest_name == "Main/8" then
        base.click_delay(coords.quest_select_main_8)
    elseif quest_name == "Main/9" then
        base.click_delay(coords.quest_select_main_9)
    elseif quest_name == "Main/10" then
        base.click_delay(coords.quest_select_main_10)
    elseif quest_name == "WeekRot/Exp" then
        base.click_delay(coords.quest_select_week_rot_exp)
    elseif quest_name == "WeekRot/Mst" then
        base.click_delay(coords.quest_select_week_rot_mst)
    elseif quest_name == "Event/3" then
        base.check_image(images.quest_event_3_text, nil, function(loc)
            base.click_delay(loc)
        end)
    elseif quest_name == "Event/VH-9" then
        quest_handle_event_vh(images.quest_event_vh_quest_9_text, coords.quest_select_event_vh_9)
    elseif quest_name == "Event/VH-10" then
        quest_handle_event_vh(images.quest_event_vh_quest_10_text, coords.quest_select_event_vh_10)
    elseif quest_name == "Event/CHL" then
        base.click_delay(coords.quest_select_event_challenge)
    else
        sys.terminate(string.format("Unknown quest to select: %s", quest_name))
    end
end

---Click on the quest start button until the in-game screen is confirmed, then update the status.
---If the message of insufficient AP is detected, status will be updated to QUEST_READY_INSUFFICIENT instead.
function action.quest_start_quest(click_start, check_ap_refill)
    if check_ap_refill == nil then
        check_ap_refill = true
    end

    -- Check quest start indicators
    if not configs.pass_only_ssr_drop and base.check_image(images.in_game_loop_icon, status.QUEST_IN_GAME_LOOP) then
        return
    elseif configs.pass_only_ssr_drop and base.check_image(images.in_game_2x_icon, status.QUEST_IN_GAME_SSR_PRE_WAVE_3) then
        return
    end

    if base.check_image(images.unable_to_start_auto, status.QUEST_READY_INSUFFICIENT) then
        return
    end

    if check_ap_refill and base.check_image(images.ap_refill_indicator, status.FILL_AP_ITEM) then
        return
    end

    -- Only click the start button if `click_start` is not given or `true`
    if click_start == nil or click_start then
        base.click_delay(coords.quest_start_btn)
    end
end

---Check if the current progress is wave 3.
function action.quest_check_into_wave_3()
    counter.unlock()
    base.check_image(images.in_game_wave_3, status.QUEST_IN_GAME_SSR_AT_WAVE_3)
end

---Check the current SSR drop status and change to corresponding status.
function action.quest_check_ssr_drop()
    -- If quest abort confirm dialog is found, change the status and terminate the action
    if base.check_image(images.in_game_abort_confirm_txt, status.QUEST_IN_GAME_ABORT_CONFIRM) then
        return
    end

    -- Click the menu button
    if not action.quest_close_menu(false) then
        base.click_delay(coords.quest_menu_btn)
    end

    -- Click abort button if no SSR drop
    if base.check_image(images.in_game_drop_ssr_0) then
        base.click_delay(coords.quest_abort_btn)
        return
    end

    -- Close the menu if dropped
    if base.check_image(images.in_game_drop_ssr_1, status.QUEST_IN_GAME_SSR_DROPPED) then
        action.quest_close_menu()
        return
    end
end

---Confirm the abort dialog.
function action.quest_confirm_abort()
    if base.check_image(images.in_game_abort_confirm_txt) then
        base.click_delay(coords.quest_abort_confirm_btn)
        counter.count_fail()
    end

    -- Check back to main menu
    base.check_image(images.friend_icon, status.QUEST_SELECT)
end

---Check if the current screen is an intermediate quest complete screen.
function action.quest_check_single_loop_complete()
    counter.unlock()
    if base.check_image(images.quest_complete_text, status.QUEST_COMPLETE) then
        base.click_delay(coords.quest_result_single_continue)
    end
end

---Check if the quest is completed. (Single run)
function action.quest_check_complete_ssr_dropped()
    counter.count_pass()

    sys.terminate("SSR Dropped")

    -- Terminate the script early
    --if base.check_image(images.result_single_indicator, status.QUEST_RESULT_SINGLE) then
    --    base.click_delay(coords.quest_result_single_close)
    --end
end

---Update the status to the initial in-game status if the screen appears to be playing in auto with loop.
function action.quest_wait_in_game_loop()
    counter.count_pass()
    base.check_image(images.in_game_loop_icon, status.initial_in_game())
end

---Update the status to QUEST_RESULT_LOOP if the looped result dialog popped up.
function action.quest_wait_result_loop()
    base.check_image(images.result_loop_indicator, status.QUEST_RESULT_LOOP)
end

---Close the loop result dialog.
function action.quest_check_result_loop()
    if counter.count_pass() and configs.log_drop then
        wait(5)  -- 5 secs wait for the animation to show the rewards for capturing
        logger.screenshot_message_file_suffix("Drop in a loop", "drop")
    end
    if not base.check_image(images.result_single_indicator, status.QUEST_RESULT_SINGLE) then
        base.click_delay(coords.quest_result_loop_close)
    end
end

---Check the single game result to proceed to go back to the quest select screen.
function action.quest_check_result_single()
    if not base.check_image(images.friend_icon, status.QUEST_SELECT) then
        base.click_delay(coords.quest_result_single_close)
    end
end

---Open the AP filling dialog.
function action.fill_ap()
    if not base.check_image(images.ap_refill_indicator, status.FILL_AP_ITEM) then
        base.click_delay(coords.refill_quest_ready)
    end
    -- Handle the case where after stamina refill,
    -- the game just starts automatically without displaying the confirmation dialog
    action.quest_wait_in_game_loop()
end

---Select the item to use for filling AP.
function action.fill_ap_select_item()
    if not base.check_image(images.ap_refill_confirm_indicator, status.FILL_AP_CONFIRM) then
        base.click_delay(coords.refill_by_gem)
    end
end

---Confirm the AP refill.
function action.fill_ap_confirm()
    if not base.check_image(images.ap_refill_refilled_indicator, status.FILL_AP_FILLED) then
        base.click_delay(coords.refill_confirm)
    end

    action.quest_start_quest(true, false)
end

---Close the AP refill confirmation dialog.
function action.fill_check_filled()
    if not base.check_image(images.quest_ready_indicator, status.QUEST_READY) then
        base.click_delay(coords.refill_filled_close)
    end
end

---Close the in-battle menu.
function action.quest_close_menu(dismiss)
    if dismiss == nil then
        dismiss = true
    end

    base.check_image(images.in_game_menu_back_btn, status.get_current(), function(loc)
        if dismiss then
            base.click_delay(loc)
        end
    end)
end

return action
