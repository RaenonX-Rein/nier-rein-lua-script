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
configs.total_games = 100
configs.pass_only_ssr_drop = true

configs.quest_select = "DarkMem/Coin-2"
-- DarkMem/Ticket-1
-- DarkMem/Coin-1
-- DarkMem/Ticket-2
-- DarkMem/Coin-2
-- DarkMem/Std
-- DarkMem/Exp
-- DarkMem/Mst
-- Main/4
-- Main/9
-- Main/10
-- WeekRot/Exp
-- WeekRot/Mst
-- Event/VH-9
-- Event/VH-10
-- Event/CHL
--endregion

--region Script
configs.default_click_delay = 1
configs.random_click = false
configs.random_click_offset = 5
--endregion

return configs
