--region Imports
base = require(scriptPath() .. "mod/base")
coords = require(scriptPath() .. "mod/coords")
configs = require(scriptPath() .. "mod/configs")
images = require(scriptPath() .. "mod/images")
status = require(scriptPath() .. "mod/status")
utils = require(scriptPath() .. "mod/utils")
--endregion

local action_dark = {}

local quest_idx_advance_lock = false

local preset_count = table.getn(configs.config_dark_mem_idx)

local preset_idx_current = 1  -- -1 for not in use

local preset_idx_used = utils.init_table(false, preset_count)

local current_unit_idx = configs.config_dark_mem_idx[1]

function advance_dark_mem_idx()
    if quest_idx_advance_lock then
        return
    end

    -- Set current preset idx to used
    if preset_idx_current ~= -1 then
        preset_idx_used[preset_idx_current] = true
    end

    quest_idx_advance_lock = true

    -- Set index according to preset order first
    for preset_idx = 1, preset_count do
        if not preset_idx_used[preset_idx] then
            preset_idx_current = preset_idx
            current_unit_idx = configs.config_dark_mem_idx[preset_idx]
            return
        end
    end

    preset_idx_current = -1  -- Preset not in use (all used)
    current_unit_idx = current_unit_idx + 1
    -- Rotate back to 1 if the index goes out of bound
    if current_unit_idx > table.getn(coords.quest_select_dark_mem) then
        current_unit_idx = 1
    end
end

---Select dark mem unit for the quest according to the current index.
---
---Also change to dark mem unit select state if the indicator for dark mem list is no longer available.
function action_dark.select_unit()
    local unit_loc = coords.quest_select_dark_mem[current_unit_idx]

    if base.check_image(images.quest_dark_mem_unit_indicator, status.QUEST_DARK_MEM_SELECT, function()
        quest_idx_advance_lock = false
    end) then
        return
    end

    -- Only click the unit icon if found the list indicator
    if base.check_image(images.quest_dark_mem_list_indicator, status.get_current()) then
        base.click_delay(unit_loc)
    end
end

---Check if the standard quest is locked and return the result.
function action_dark.check_std_locked()
    base.check_image(images.quest_dark_mem_std_locked, status.QUEST_DARK_MEM_STD_LOCKED)
end

---Keeps clicking the back button until backed to the dark mem list page.
---
---Also changes the state to dark mem list if the corresponding indicator is found,
---and, advances the current dark mem index.
function action_dark.back_to_list()
    -- Click on back ONLY IF found the dark mem unit indicator
    base.check_image(images.quest_dark_mem_unit_indicator, nil, function()
        base.click_delay(coords.quest_select_dark_mem_back)
    end)

    -- Change the current state to dark mem list if found the list indicator
    base.check_image(images.quest_dark_mem_list_indicator, status.QUEST_DARK_MEM_LIST)
    advance_dark_mem_idx()
end

---Check if the expert dark memory is locked.
---
---If not and available, select it; if it's locked or not available, change the state.
function action_dark.check_dark_mem_expert()
    if base.check_image(images.quest_dark_mem_exp_locked, status.QUEST_DARK_MEM_EXP_LOCKED) then
        return
    end

    if base.check_image(images.quest_dark_mem_exp_available) then
        base.click_delay(coords.quest_select_dark_mem_exp)
        status.update(status.QUEST_READY)
    end
end

---Check if the master dark memory is locked.
---
---If not and available, select it; if it's locked or not available, change the state.
function action_dark.check_dark_mem_master()
    if base.check_image(images.quest_dark_mem_mst_locked, status.QUEST_DARK_MEM_MST_LOCKED) then
        return
    end

    if base.check_image(images.quest_dark_mem_mst_available) then
        base.click_delay(coords.quest_select_dark_mem_mst)
        status.update(status.QUEST_READY)
    else
        action_dark.back_to_list()
    end
end

return action_dark
