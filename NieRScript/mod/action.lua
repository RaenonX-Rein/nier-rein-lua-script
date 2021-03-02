--region Imports
base = require(scriptPath() .. "mod/base")
coords = require(scriptPath() .. "mod/coords")
images = require(scriptPath() .. "mod/images")
configs = require(scriptPath() .. "mod/configs")
counter = require(scriptPath() .. "mod/counter")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

local action = {}

local function quest_dark_mem_swipe_up()
    setDragDropTiming(50, 50)  -- Press & hold for 50 ms; hold for 50 ms before release
    setDragDropStepCount(30)  -- Moving step count
    setDragDropStepInterval(10)  -- Step changing interval in ms

    dragDrop(coords.quest_select_dark_mem_swipe_1, coords.quest_select_dark_mem_swipe_2)
    wait(0.5)  -- Wait for swipe animation recovery
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
        return
    end

    -- If friend icon is detected, set the status to QUEST_READY
    -- and click on the configured desired quest to enter the quest ready screen
    local quest_name = configs.quest_select

    if quest_name == "DarkMem/Ticket-1" then
        base.click_delay(coords.quest_select_dark_mem_ticket_1)
    elseif quest_name == "DarkMem/Coin-1" then
        base.click_delay(coords.quest_select_dark_mem_coin_1)
    elseif quest_name == "DarkMem/Ticket-2" then
        quest_dark_mem_swipe_up()
        base.click_delay(coords.quest_select_dark_mem_ticket_2)
    elseif quest_name == "DarkMem/Coin-2" then
        quest_dark_mem_swipe_up()
        base.click_delay(coords.quest_select_dark_mem_coin_2)
    elseif quest_name == "Main/9" then
        base.click_delay(coords.quest_select_main_9)
    elseif quest_name == "Main/10" then
        base.click_delay(coords.quest_select_main_10)
    elseif quest_name == "WeekRot" then
        base.click_delay(coords.quest_select_week_rot)
    elseif quest_name == "EventVH/9" then
        quest_handle_event_vh(images.quest_event_vh_quest_9_text, coords.quest_select_event_vh_9)
    elseif quest_name == "EventVH/10" then
        quest_handle_event_vh(images.quest_event_vh_quest_10_text, coords.quest_select_event_vh_10)
    else
        sys.terminate(string.format("Unknown quest to select: %s", quest_name))
    end
end

---Click on the quest start button until the in-game screen is confirmed, then update the status.
---If the message of insufficient AP is detected, status will be updated to QUEST_READY_INSUFFICIENT instead.
function action.quest_start_quest(click_start)
    if base.check_image(images.in_game_loop_icon, status.QUEST_IN_GAME_LOOP) then
        return
    end

    if base.check_image(images.unable_to_start_auto, status.QUEST_READY_INSUFFICIENT) then
        return
    end

    if click_start == nil or click_start then
        base.click_delay(coords.quest_start_btn)
    end
end

---Check if the current screen is an intermediate quest complete screen.
function action.quest_check_complete()
    counter.unlock()
    base.check_image(images.quest_complete_text, status.QUEST_COMPLETE)
end

---Update the status to QUEST_IN_GAME_LOOP if the screen appears to be playing in auto with loop.
function action.quest_wait_in_game_loop()
    counter.count_pass()
    base.check_image(images.in_game_loop_icon, status.QUEST_IN_GAME_LOOP)
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
    -- Sometimes refill confirmation dialog could be dismissed by the lagged click,
    -- which causes the screen back to the quest ready state.
    -- Also, the refill confirm button location is almost the same as start quest button
    action.quest_start_quest()
end

---Close the AP refill confirmation dialog.
function action.fill_check_filled()
    if not base.check_image(images.quest_ready_indicator, status.QUEST_READY) then
        base.click_delay(coords.refill_filled_close)
    end
end

---Close the in-battle menu.
function action.quest_close_menu()
    base.check_image(images.in_game_menu_back_btn, status.get_current(), function(loc)
        base.click_delay(loc)
    end)
end

return action
