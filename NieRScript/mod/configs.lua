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
configs.total_games = 610
configs.pass_only_ssr_drop = true

configs.fill_item = "AP/L"
-- Gems
-- AP/L

configs.quest_select = "DarkMem/Std"
-- DarkMem/Ticket-1
-- DarkMem/Coin-1
-- DarkMem/Ticket-2
-- DarkMem/Coin-2
-- DarkMem/Std
-- DarkMem/Exp
-- DarkMem/Mst
-- Main/1
-- Main/4
-- Main/6
-- Main/7
-- Main/8
-- Main/9
-- Main/10
-- WeekRot/Exp
-- WeekRot/Mst
-- Event/3
-- Event/9
-- Event/VH-10
-- Event/CHL

function configs.get_status_file_name()
    local q = configs.quest_select
    if q == "DarkMem/Std" then
        return "stats-std"
    elseif q == "DarkMem/Exp" then
        return "stats-exp"
    elseif q == "DarkMem/Mst" then
        return "stats-mst"
    end

    return "stats"
end
--endregion

--region Script
configs.default_click_delay = 1
configs.random_click = false
configs.random_click_offset = 5
--endregion

return configs
