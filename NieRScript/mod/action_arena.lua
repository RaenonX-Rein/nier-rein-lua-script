--region Imports
base = require(scriptPath() .. "mod/base")
coords = require(scriptPath() .. "mod/coords")
configs = require(scriptPath() .. "mod/configs")
images = require(scriptPath() .. "mod/images")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

local action_arena = {}

local function click_arena_target(arena_target_idx)
    if arena_target_idx == 1 then
        base.click_delay(coords.arena_target_1)
    elseif arena_target_idx == 2 then
        base.click_delay(coords.arena_target_2)
    elseif arena_target_idx == 3 then
        base.click_delay(coords.arena_target_3)
    else
        sys.terminate(string.format("Unknown arena target idx: %d", arena_target_idx))
    end
end

local function is_arena_targeted(arena_target_idx)
    if arena_target_idx == 1 then
        return base.check_image(images.arena_target_1)
    elseif arena_target_idx == 2 then
        return base.check_image(images.arena_target_2)
    elseif arena_target_idx == 3 then
        return base.check_image(images.arena_target_3)
    else
        sys.terminate(string.format("Unknown arena target idx: %d", arena_target_idx))
    end
end

local function is_arena_target_dead(arena_target_idx)
    if arena_target_idx == 1 then
        return base.check_image(images.arena_dead_1)
    elseif arena_target_idx == 2 then
        return base.check_image(images.arena_dead_2)
    elseif arena_target_idx == 3 then
        return base.check_image(images.arena_dead_3)
    else
        sys.terminate(string.format("Unknown arena target idx: %d", arena_target_idx))
    end
end

local function click_arena_target_2()
    if not is_arena_target_dead(configs.arena_target_idx_1) then
        return
    end

    local arena_target_idx = configs.arena_target_idx_2

    if is_arena_target_dead(arena_target_idx) then
        return
    end

    if not is_arena_targeted(arena_target_idx) then
        click_arena_target(arena_target_idx)
    end
    target_2_targeted = true
end

--- Open the arena enemy selection menu.
function action_arena.arena_open_menu()
    base.check_image(images.arena_open_menu_text, nil, function(loc)
        base.click_delay(loc)
    end)
    base.check_image(images.arena_start_battle_text, status.ARENA_SELECT)
end

--- Start the battle.
function action_arena.arena_start_battle(check_refill)
    -- Click start battle
    -- - Specify the current state explicitly for state reassignment
    --   by the call from `action_arena.arena_bp_fill_dismiss_dialog`
    base.check_image(images.arena_start_battle_text, status.ARENA_SELECT, function(loc)
        -- Check players to avoid
        if base.check_image(images.arena_avoid_1, nil) then
            base.click_delay(coords.arena_select_2)
        end
        base.click_delay(loc)
    end)
    -- Check pre battle
    base.check_image(images.arena_pre_battle_wave, status.ARENA_PRE_BATTLE)
    -- Check for BP refill indicator
    if check_refill == nil or check_refill then
        base.check_image(images.arena_bp_refill_txt, status.ARENA_BP_ITEM)
    end
end

--- Choose the item for BP refill.
function action_arena.arena_bp_fill_item()
    base.check_image(images.arena_bp_refill_txt, nil, function()
        base.click_delay(coords.refill_by_gem)
    end)
    base.check_image(images.arena_bp_fill_confirm_indicator, status.ARENA_BP_CONFIRM_GEM)
end

--- Confirm BP refill by gem.
function action_arena.arena_bp_fill_confirm_gems()
    base.check_image(images.arena_bp_fill_confirm_indicator, nil, function()
        base.click_delay(coords.refill_confirm)
    end)
    base.check_image(images.arena_bp_fill_complete_indicator, status.ARENA_BP_COMPLETE)
end

--- Dismiss BP refill completed dialog.
function action_arena.arena_bp_fill_dismiss_dialog()
    base.check_image(images.arena_bp_fill_complete_indicator, nil, function()
        base.click_delay(coords.refill_filled_close)
    end)
    action_arena.arena_start_battle(false)
end

--- Handle actions in arena battle.
function action_arena.arena_in_battle()
    counter.unlock()
    click_arena_target_2()
    base.check_image(images.arena_in_battle_indicator, nil, function()
        base.click_delay(coords.arena_p1_s2, 0.05)
        base.click_delay(coords.arena_p2_s1, 0.05)
        base.click_delay(coords.arena_p3_s2, 0.05)
    end)
    base.check_image(images.arena_battle_end, status.ARENA_BATTLE_END, function(loc)
        base.click_delay(loc)
    end)
end

--- Perform actions before the battle then change the state to `ARENA_IN_BATTLE`.

function action_arena.arena_pre_battle()
    base.check_image(images.arena_pre_battle_wave, status.ARENA_IN_BATTLE, function()
        wait(0.5)
        click_arena_target(configs.arena_target_idx_1)
    end)
end

--- Handle actions when the battle ends.
function action_arena.arena_battle_end()
    counter.count_pass()
    base.check_image(images.arena_battle_end, nil, function(loc)
        base.click_delay(loc)
    end)
    action_arena.arena_open_menu()
end

return action_arena
