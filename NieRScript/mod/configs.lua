local configs = {}

--region System
configs.debug = true
configs.log_status = false
configs.log_random_click = false

configs.min_similarity = 0.85
--endregion

--region Toast
configs.toast_enable = true
configs.toast_cd_sec = 5
--endregion

--region Game
configs.fill_items = {
    "Gems",
    "AP/S",
    "AP/M",
    "AP/L",
}

configs.quests = {
    "--Row--",
    "DarkMem/Ticket-1",
    "DarkMem/Coin-1",
    "DarkMem/Ticket-2",
    "DarkMem/Coin-2",
    "DarkMem/Std",
    "DarkMem/Exp",
    "DarkMem/Mst",
    "--Row--",
    "Auto-10",
    "Arena",
}
--endregion

--region Script
configs.default_click_delay = 1
configs.default_drag_drop_delay = 1
configs.random_click = false
configs.random_click_offset = 5
--endregion

--region Functions
local function add_radio_buttons(tbl)
    for idx, quest in ipairs(tbl) do
        if quest == "--Row--" then
            newRow()
        else
            addRadioButton(quest, idx)
        end
    end
end

local function show_quest_config_dialog()
    dialogInit()

    -- Select Quest
    addTextView("Quest to play")
    newRow()
    addRelativeRadioGroup("config_selected_quest_idx", 1, 4)
    add_radio_buttons(configs.quests)

    -- Play Count
    newRow()
    addTextView("Play count: ")
    addEditNumber("config_total_games", 100)

    -- Play Count
    newRow()
    addTextView("Dark Mem Start Index (index-1): ")
    addEditNumber("config_dark_mem_idx", 1)

    -- Arena target IDX
    newRow()
    addTextView("Arena Target # (1): ")
    addEditNumber("config_arena_target_idx_1", 2)
    newRow()
    addTextView("Arena Target # (2): ")
    addEditNumber("config_arena_target_idx_2", 3)

    -- Fill item
    newRow()
    addRelativeRadioGroup("config_fill_item_idx", 1, 2)
    add_radio_buttons(configs.fill_items)

    -- Reset counter
    newRow()
    addCheckBox("config_reset_counter", "Reset Counter", true)

    -- Log Drop
    newRow()
    addCheckBox("config_log_drop", "Log Drop", true)

    dialogShowFullScreen("Config")
end

local function load_config_data()
    configs.quest_select = configs.quests[config_selected_quest_idx]
    configs.fill_item = configs.fill_items[config_fill_item_idx]
    configs.config_dark_mem_idx = config_dark_mem_idx
    configs.total_games = config_total_games
    configs.reset_counter = config_reset_counter
    configs.log_drop = config_log_drop
    configs.arena_target_idx_1 = config_arena_target_idx_1
    configs.arena_target_idx_2 = config_arena_target_idx_2
end

local function validate_config()
    if configs.arena_target_idx_1 == configs.arena_target_idx_2 then
        scriptExit("Arena target IDXs must not be the same.")
    end
end
--endregion

--region Properties
show_quest_config_dialog()
load_config_data()
validate_config()

local q = configs.quest_select

function configs.get_status_file_name()
    if q == "DarkMem/Std" then
        return "stats-std"
    elseif q == "DarkMem/Exp" then
        return "stats-exp"
    elseif q == "DarkMem/Mst" then
        return "stats-mst"
    end

    return "stats"
end

function configs.get_not_using_battery_save()
    return q == "DarkMem/Std" or q == "DarkMem/Exp" or q == "DarkMem/Mst" or q == "Memory/Sergeant10"
end
--endregion

return configs
