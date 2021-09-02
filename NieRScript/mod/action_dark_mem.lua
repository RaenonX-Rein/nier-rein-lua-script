--region Imports
base = require(scriptPath() .. "mod/base")
coords = require(scriptPath() .. "mod/coords")
configs = require(scriptPath() .. "mod/configs")
images = require(scriptPath() .. "mod/images")
status = require(scriptPath() .. "mod/status")
sys = require(scriptPath() .. "mod/sys")
--endregion

local action_dark = {}

local quest_idx_advance_lock = false

function advance_dark_mem_idx()
    if quest_idx_advance_lock then
        return
    end

    configs.config_dark_mem_idx = configs.config_dark_mem_idx + 1
    -- Rotate back to 1 if the index goes out of bound
    if configs.config_dark_mem_idx > table.getn(coords.quest_select_dark_mem) then
        configs.config_dark_mem_idx = 1
    end
end

---Select dark mem unit for the quest according to the current index.
---
---Also change to dark mem unit select state if the indicator for dark mem list is no longer available.
function action_dark.select_unit()
    local unit_loc = coords.quest_select_dark_mem[configs.config_dark_mem_idx]

    if base.check_image(images.quest_dark_mem_unit_indicator, status.QUEST_DARK_MEM_SELECT, function()
        quest_idx_advance_lock = false
    end) then
        return
    end

    base.click_delay(unit_loc)
end

---Check if the standard quest is locked and return the result.
function action_dark.check_std_locked()
    return base.check_image(images.quest_dark_mem_lock_icon, status.QUEST_DARK_MEM_LOCKED)
end

---Keeps clicking the back button until backed to the dark mem list page.
---
---Also changes the state to dark mem list if the corresponding indicator is found,
---and, advances the current dark mem index.
function action_dark.back_to_list()
    base.click_delay(coords.quest_select_dark_mem_back)
    base.check_image(images.quest_dark_mem_list_indicator, status.QUEST_DARK_MEM_LIST)
    advance_dark_mem_idx()
end

return action_dark
