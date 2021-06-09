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
    return base.check_image_swipe_up(
        images.quest_dark_mem_2_coin_text,
        coords.quest_select_dark_mem_swipe_1,
        coords.quest_select_dark_mem_swipe_2
    )
end

local function quest_select_memory_9()
    return base.check_image_swipe_up(
        images.quest_mem_9_text,
        coords.quest_select_memory_swipe_1,
        coords.quest_select_memory_swipe_2,
        nil,
        function(loc)
            base.click_delay(loc)
        end
    )
end

local function quest_select_memory_10()
    return base.check_image_swipe_up(
        images.quest_mem_10_text,
        coords.quest_select_memory_swipe_1,
        coords.quest_select_memory_swipe_2,
        nil,
        function(loc)
            base.click_delay(loc)
        end
    )
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

    -- Found quest and is VH
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
    elseif quest_name == "Event/9" then
        base.check_image(images.quest_event_9_text, nil, function(loc)
            base.click_delay(loc)
        end)
    elseif quest_name == "Event/VH-10" then
        quest_handle_event_vh(images.quest_event_vh_quest_10_text, coords.quest_select_event_vh_10)
    elseif quest_name == "Event/CHL" then
        base.click_delay(coords.quest_select_event_challenge)
    elseif quest_name == "Memory/Sergeant10" then
        quest_select_memory_10()
    elseif quest_name == "Memory/Witch9" then
        quest_select_memory_9()
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
    if not configs.get_not_using_battery_save() and base.check_image(images.in_game_loop_icon, status.QUEST_IN_GAME_LOOP) then
        return
    elseif configs.get_not_using_battery_save() and base.check_image(images.in_game_2x_icon, status.QUEST_IN_GAME_PRE_WAVE_3) then
        return
    end

    if base.check_image(images.unable_to_start_auto, status.QUEST_READY_INSUFFICIENT) then
        return
    end

    if check_ap_refill and action.check_ap_refill() then
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
    base.check_image(images.in_game_wave_3, status.QUEST_IN_GAME_AT_WAVE_3)

    local quest_name = configs.quest_select

    if quest_name == "Memory/Sergeant10" or quest_name == "Memory/Witch9" then
        -- Click AUTO to disable if enabled
        base.check_image(images.in_game_is_auto, nil, function(loc)
            base.click_delay(loc)
        end)
    end
end

---Actions to be performed at wave 3.
function action.quest_handle_at_wave_3()
    local quest_name = configs.quest_select

    if quest_name == "DarkMem/Std" or quest_name == "DarkMem/Exp" or quest_name == "DarkMem/Mst" then
        action.quest_check_ssr_drop()
    elseif quest_name == "Memory/Sergeant10" then
        action.quest_sergeant_10_wave_3()
    else
        sys.terminate(string.format("Unknown quest to perform wave 3 action: %s", quest_name))
    end
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

---Actions to perform during wave 3 of sergeant memory 10.
function action.quest_sergeant_10_wave_3()
    -- Click AUTO if is not auto
    base.check_image(images.in_game_is_not_auto, nil, function(loc)
        base.click_delay(loc)
    end)

    -- Target the sergeant if not yet targeted
    if not base.check_image(images.in_game_target_sergeant) then
        base.click_delay(coords.in_game_target_sergeant)
    end

    -- Count as fail if back to the menu
    if base.check_image(images.friend_icon, status.QUEST_SELECT) then
        counter.count_fail()
    end

    action.quest_check_result_single()
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
        base.click_delay(coords.quest_result_loop_continue)
    end
end

---Check if the quest is completed. (Single run)
function action.quest_check_complete_ssr_dropped()
    counter.count_pass()

    -- Terminate the script early
    sys.terminate("SSR Dropped")
end

---Update the status to the initial in-game status if the screen appears to be playing in auto with loop.
function action.quest_wait_in_game_loop()
    counter.count_pass()
    base.check_image(images.in_game_loop_icon, status.initial_in_game())
    action.check_ap_refill()
end

---Update the status to QUEST_RESULT_LOOP if the looped result dialog popped up.
function action.quest_wait_result_loop()
    base.check_image(images.result_loop_indicator, status.QUEST_RESULT_LOOP_DIALOG)
end

---Close the loop result dialog.
function action.quest_check_loop_result_dialog()
    if counter.count_pass() and configs.log_drop then
        wait(5)  -- 5 secs wait for the animation to show the rewards for capturing
        logger.screenshot_message_file_suffix("Drop in a loop", "drop")
    end
    -- Click to close the loop result dialog until the indicator is found
    if not base.check_image(images.result_loop_end_indicator, status.QUEST_RESULT_LOOP) then
        base.click_delay(coords.quest_result_loop_result_close)
    end
end

--Continue the loop.
function action.quest_check_loop_result()
    base.click_delay(coords.quest_result_loop_start_more)
end

---If is single game, click "more".
function action.quest_check_result_single()
    base.check_image(images.result_single_indicator, status.QUEST_IN_GAME_PRE_WAVE_3, function(loc)
        counter.count_pass()
        base.click_delay(loc)
    end)

    action.check_ap_refill()
end

---Check if AP needs to be refilled.
function action.check_ap_refill()
    return base.check_image(images.ap_refill_indicator, status.FILL_AP_ITEM)
end

---Open the AP filling dialog.
function action.fill_ap()
    if not action.check_ap_refill() then
        base.click_delay(coords.refill_quest_ready)
    end
    -- Handle the case where after stamina refill,
    -- the game just starts automatically without displaying the confirmation dialog
    action.quest_wait_in_game_loop()
end

local function fill_ap_item_swipe_up()
    return base.check_image_swipe_up(
        images.ap_refill_ap_potion_lg,
        coords.refill_item_swipe_1,
        coords.refill_item_swipe_2
    )
end

---Select the item to use for filling AP.
function action.fill_ap_select_item()
    if base.check_image(images.ap_refill_confirm_indicator, status.FILL_AP_CONFIRM) then
        return
    end

    local fill_item = configs.fill_item

    if fill_item == "Gems" then
        base.click_delay(coords.refill_by_gem)
    elseif fill_item == "AP/L" then
        if not fill_ap_item_swipe_up() then
            return
        end
        base.click_delay(coords.refill_by_pot_lg)
    else
        sys.terminate(string.format("Unknown AP fill item: %s", quest_name))
    end
end

---Confirm the AP refill.
function action.fill_ap_confirm()
    if not base.check_image(images.ap_refill_refilled_indicator, status.FILL_AP_FILLED) then
        base.click_delay(coords.refill_confirm)
    end

    -- Hotfix: somehow after fill, the quest dialog disappears occasionally
    action.quest_select_quest()
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
