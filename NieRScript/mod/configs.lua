local configs = {}

--region System
configs.debug = true
configs.log_status = false
configs.log_random_click = false
configs.log_drop = true

configs.min_similarity = 0.85
--endregion

--region Toast
configs.toast_enable = true
configs.toast_cd_sec = 5
--endregion

--region Game
configs.fill_item = "AP/L"
-- Gems
-- AP/L

configs.quests = {
    "DarkMem/Ticket-1",
    "DarkMem/Coin-1",
    "DarkMem/Ticket-2",
    "DarkMem/Coin-2",
    "DarkMem/Std",
    "DarkMem/Exp",
    "DarkMem/Mst",
    "Main/1",
    "Main/4",
    "Main/6",
    "Main/7",
    "Main/8",
    "Main/9",
    "Main/10",
    "WeekRot/Exp",
    "WeekRot/Mst",
    "Event/3",
    "Event/9",
    "Event/VH-10",
    "Event/CHL",
    "Memory/Sergeant10",
}
--endregion

--region Script
configs.default_click_delay = 1
configs.default_drag_drop_delay = 1
configs.random_click = false
configs.random_click_offset = 5
--endregion

--region Functions
local function show_quest_config_dialog()
    dialogInit()

    addTextView("Quest to play")
    newRow()
    addRelativeRadioGroup("config_selected_quest_idx", 1, 4)
    for idx, quest in ipairs(configs.quests) do
        addRadioButton(quest, idx)
    end
    newRow()
    addTextView("Play count: ")
    addEditNumber("config_total_games", 100)
    dialogShowFullScreen("Config")
end

local function load_config_data()
    configs.quest_select = configs.quests[config_selected_quest_idx]
    configs.total_games = config_total_games
end
--endregion

--region Properties
show_quest_config_dialog()
load_config_data()

local q = configs.quest_select

function configs.get_status_file_name()
    if q == "DarkMem/Std" then
        return "stats-std"
    elseif q == "DarkMem/Exp" then
        return "stats-exp"
    elseif q == "DarkMem/Mst" then
        return "stats-mst"
    elseif q == "Memory/Sergeant10" then
        return "stats-mem10"
    end

    return "stats"
end

function configs.get_not_using_battery_save()
    return q == "DarkMem/Std" or q == "DarkMem/Exp" or q == "DarkMem/Mst" or q == "Memory/Sergeant10"
end
--endregion

return configs
