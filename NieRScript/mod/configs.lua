local configs = {}

--region System
configs.debug = true
configs.log_status = true
configs.log_random_click = false
configs.log_drop = true
--endregion

--region Toast
configs.toast_enable = true
configs.toast_cd_sec = 5
--endregion

--region Game
configs.total_games = 100

configs.quest_select = "WeekRot"
--DarkMem/Ticket
--DarkMem/Coin
--WeekRot
--endregion

--region Script
configs.default_click_delay = 1
configs.random_click = false
configs.random_click_offset = 5
--endregion

return configs
