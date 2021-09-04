--region Imports
base = require(scriptPath() .. "mod/base")
coords = require(scriptPath() .. "mod/coords")
configs = require(scriptPath() .. "mod/configs")
counter = require(scriptPath() .. "mod/counter")
images = require(scriptPath() .. "mod/images")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

local action_quest = {}

---Select the quest to auto if the current page is in quest selection menu.
function action_quest.quest_select_quest()
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

    if quest_name:find("^DarkMem/Std") then
        base.click_delay(coords.quest_select_dark_mem_std)
    elseif quest_name == "DarkMem/Exp" then
        base.click_delay(coords.quest_select_dark_mem_exp)
    elseif quest_name == "DarkMem/Mst" then
        base.click_delay(coords.quest_select_dark_mem_mst)
    else
        sys.terminate(string.format("Unknown quest to select: %s", quest_name))
    end
end

---Click on the quest start button until the in-game screen is confirmed, then update the status.
---If the message of insufficient AP is detected, status will be updated to QUEST_READY_INSUFFICIENT instead.
function action_quest.quest_start_quest(click_start, check_ap_refill)
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

    if check_ap_refill and action_quest.check_ap_refill() then
        return
    end

    -- Only click the start button if `click_start` is not given or `true`
    if click_start == nil or click_start then
        base.click_delay(coords.quest_start_btn)
    end
end

---Check if the current progress is wave 3.
function action_quest.quest_check_into_wave_3()
    counter.unlock()
    base.check_image(images.in_game_wave_3, status.QUEST_IN_GAME_AT_WAVE_3)
end

---Actions to be performed at wave 3.
function action_quest.quest_handle_at_wave_3()
    local quest_name = configs.quest_select

    if configs.is_current_dark_mem() then
        status.update(status.QUEST_ATTEMPT_OPEN_MENU)
    elseif quest_name == "Memory/Sergeant10" then
        action_quest.quest_sergeant_10_wave_3()
    else
        sys.terminate(string.format("Unknown quest to perform wave 3 action: %s", quest_name))
    end
end

---Actions to click on the menu button for the next action
function action_quest.quest_click_menu()
    base.click_delay(coords.quest_menu_btn)

    if configs.is_current_dark_mem() then
        -- Change status if menu back button is found (menu opened)
        base.check_image(images.in_game_menu_back_btn, status.QUEST_CHECK_SSR_DROP)
    end
end

---Check the current SSR drop status and change to corresponding status.
function action_quest.quest_check_ssr_drop()
    -- Click abort button if no SSR drop
    if base.check_image(images.in_game_drop_ssr_0) then
        status.update(status.QUEST_IN_GAME_ABORT)
        return
    end

    -- Close the menu if dropped and change to clear state if dropped
    if base.check_image(images.in_game_drop_ssr_1, status.QUEST_IN_GAME_SSR_DROPPED) then
        action_quest.quest_close_menu()
        return
    end
end

---Actions to abort the current run.
function action_quest.quest_abort_run()
    base.click_delay(coords.quest_abort_btn)

    -- If quest abort confirm dialog is found, change the status
    base.check_image(images.in_game_abort_confirm_txt, status.QUEST_IN_GAME_ABORT_CONFIRM)
end

---Actions to perform during wave 3 of sergeant memory 10.
function action_quest.quest_sergeant_10_wave_3()
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

    action_quest.quest_check_result_single()
end

---Confirm the abort dialog.
function action_quest.quest_confirm_abort()
    if base.check_image(images.in_game_abort_confirm_txt) then
        base.click_delay(coords.quest_abort_confirm_btn)
        counter.count_fail()
    end

    -- Check back to main menu
    base.check_image(images.friend_icon, status.QUEST_SELECT)
end

---Check if the current screen is an intermediate quest complete screen.
function action_quest.quest_check_single_loop_complete()
    counter.unlock()
    if base.check_image(images.quest_complete_text, status.QUEST_COMPLETE) then
        base.click_delay(coords.quest_result_loop_continue)
    end
end

---Check if the quest is completed.
function action_quest.quest_check_complete_ssr_dropped()
    base.check_image(images.quest_dark_mem_complete_indicator, status.QUEST_DARK_MEM_SELECT, function(loc)
        counter.count_pass()

        local quest_name = configs.quest_select

        -- Only click on the end button if it's StdLoop, otherwise terminate
        if quest_name == "DarkMem/StdLoop" then
            base.click_delay(loc)
        else
            sys.terminate("SSR Dropped")
        end

    end)
end

---Update the status to the initial in-game status if the screen appears to be playing in auto with loop.
function action_quest.quest_wait_in_game_loop()
    counter.count_pass()
    base.check_image(images.in_game_loop_icon, status.initial_in_game())
    action_quest.check_ap_refill()
end

---Update the status to QUEST_RESULT_LOOP if the looped result dialog popped up.
function action_quest.quest_wait_result_loop()
    base.check_image(images.result_loop_indicator, status.QUEST_RESULT_LOOP_DIALOG)
end

---Close the loop result dialog.
function action_quest.quest_check_loop_result_dialog()
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
function action_quest.quest_check_loop_result()
    base.click_delay(coords.quest_result_loop_start_more)
end

---If is single game, click "more".
function action_quest.quest_check_result_single()
    base.check_image(images.result_single_indicator, status.QUEST_IN_GAME_PRE_WAVE_3, function(loc)
        counter.count_pass()
        base.click_delay(loc)
    end)

    action_quest.check_ap_refill()
end

---Check if AP needs to be refilled.
function action_quest.check_ap_refill()
    return base.check_image(images.ap_refill_indicator, status.FILL_AP_ITEM)
end

---Open the AP filling dialog.
function action_quest.fill_ap()
    if not action_quest.check_ap_refill() then
        base.click_delay(coords.refill_quest_ready)
    end
    -- Handle the case where after stamina refill,
    -- the game just starts automatically without displaying the confirmation dialog
    action_quest.quest_wait_in_game_loop()
end

local function fill_ap_item_swipe_up()
    return base.check_image_swipe_up(
        images.ap_refill_ap_potion_lg,
        coords.refill_item_swipe_1,
        coords.refill_item_swipe_2
    )
end

---Select the item to use for filling AP.
function action_quest.fill_ap_select_item()
    if base.check_image(images.ap_refill_confirm_indicator, status.FILL_AP_CONFIRM) then
        return
    end

    local fill_item = configs.fill_item

    if fill_item == "Gems" then
        base.click_delay(coords.refill_by_gem)
    elseif fill_item:find("^AP") then
        if not fill_ap_item_swipe_up() then
            return
        end

        if fill_item == "AP/S" then
            -- AP/S only fill 10 AP at once, so fill 10 times = 100 AP
            for _ = 1, 10 do
                base.click_delay(coords.refill_by_pot_sm, 1)
            end
        elseif fill_item == "AP/M" then
            base.click_delay(coords.refill_by_pot_md)
        elseif fill_item == "AP/L" then
            base.click_delay(coords.refill_by_pot_lg)
        end
    else
        sys.terminate(string.format("Unknown AP fill item: %s", quest_name))
    end
end

---Confirm the AP refill.
function action_quest.fill_ap_confirm()
    if not base.check_image(images.ap_refill_refilled_indicator, status.FILL_AP_FILLED) then
        base.click_delay(coords.refill_confirm)
    end

    -- Hotfix: somehow after fill, the quest dialog disappears occasionally
    action_quest.quest_select_quest()
    action_quest.quest_start_quest(true, false)
end

---Close the AP refill confirmation dialog.
function action_quest.fill_check_filled()
    if not base.check_image(images.quest_ready_indicator, status.QUEST_READY) then
        base.click_delay(coords.refill_filled_close)
    end
end

---Close the in-battle menu.
function action_quest.quest_close_menu(dismiss)
    if dismiss == nil then
        dismiss = true
    end

    base.check_image(images.in_game_menu_back_btn, status.get_current(), function(loc)
        if dismiss then
            base.click_delay(loc)
        end
    end)
end

return action_quest
