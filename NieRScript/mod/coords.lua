utils = require(scriptPath() .. "mod/utils")

local coords = {}

--region Quest Select
-- Dark Memories (DarkMem)
coords.quest_select_dark_mem_coin_1 = Location(2076, 638)  -- Trade coin quest (DarkMem/Coin-1)
coords.quest_select_dark_mem_ticket_1 = Location(2076, 907)  -- Scout ticket quest (DarkMem/Ticket-1)
coords.quest_select_dark_mem_coin_2 = Location(2087, 816)  -- Trade coin quest (DarkMem/Coin-2)
coords.quest_select_dark_mem_ticket_2 = Location(2087, 1080)  -- Trade coin quest (DarkMem/Coin-2)
coords.quest_select_dark_mem_std = Location(2107, 362)  -- Standard dark memory
coords.quest_select_dark_mem_exp = Location(2090, 637)  -- Expert dark memory
coords.quest_select_dark_mem_mst = Location(2090, 901)  -- Master dark memory
coords.quest_select_dark_mem_swipe_1 = Location(2092, 1090)  -- Starting point of the swipe on the dark mem menu
coords.quest_select_dark_mem_swipe_2 = Location(2092, 340)  -- Ending point of the swipe on the dark mem menu
-- Main quest
coords.quest_select_main_1 = Location(986, 554)
coords.quest_select_main_4 = Location(2116, 549)
coords.quest_select_main_6 = Location(984, 991)
coords.quest_select_main_7 = Location(1360, 971)
coords.quest_select_main_8 = Location(1747, 979)
coords.quest_select_main_9 = Location(2116, 984)
coords.quest_select_main_10 = Location(2487, 984)
-- Event
coords.quest_select_event_difficulty = Location(2515, 251)  -- Click for switching the difficulty
coords.quest_select_event_list_swipe_1 = Location(2092, 1090)  -- Starting point of the swipe on the event menu
coords.quest_select_event_list_swipe_2 = Location(2092, 360)  -- Ending point of the swipe on the event menu
coords.quest_select_event_vh_10 = Location(2114, 1100)  -- Quest 10 button location
coords.quest_select_event_challenge = Location(2133, 1107)  -- Bottom of the list of the challenge quests
-- Memory
coords.quest_select_memory_swipe_1 = Location(2092, 1126)  -- Starting point of the swipe on the memory menu
coords.quest_select_memory_swipe_2 = Location(2092, 430)  -- Ending point of the swipe on the memory menu
-- Others
coords.quest_select_week_rot_exp = Location(2077, 793)  -- Weekly rotating sub-quest (Expert)
coords.quest_select_week_rot_mst = Location(2077, 1089)  -- Weekly rotating sub-quest (Master)

-- Actions
coords.quest_select_wrong_pod = Location(1918, 1215)  -- Click the cancel button if accidentally goes into pod page
--endregion

--region In Game
coords.in_game_target_sergeant = Location(116, 387)  -- Click to target the in_game_target_sergeant
--endregion

--region Quest Control
coords.quest_start_btn = Location(1757, 1281)  -- Quest start button
coords.quest_abort_btn = Location(1475, 1140)  -- Quest abort button (in menu)
coords.quest_abort_confirm_btn = Location(1759, 1112)  -- Quest abort confirm button
coords.quest_menu_btn = Location(2876, 47)  -- In-game menu button

coords.quest_result_loop_continue = Location(1803, 1312)  -- Continue the loop (skip the wait)
coords.quest_result_loop_result_close = Location(1485, 1279)  -- Close the loop result dialog
coords.quest_result_loop_start_more = Location(2362, 1357)  -- Start a new loop
--endregion

--region AP Refill
coords.refill_quest_ready = Location(1981, 1161)  -- "+" button for AP refill in quest ready page
coords.refill_item_swipe_1 = Location(1410, 1080)  -- Swipe up the fill item menu (Start)
coords.refill_item_swipe_2 = Location(1410, 580)  -- Swipe up the fill item menu (End)
coords.refill_by_gem = Location(1477, 522)  -- Click to refill by Gem
coords.refill_by_pot_lg = Location(1485, 1075)  -- Click to refill by AP Potion L
coords.refill_confirm = Location(1760, 1282)  -- Confirm AP refill
coords.refill_filled_close = Location(1484, 1115)  -- Close the AP filled dialog
--endregion

--region Arena
coords.arena_p1_s2 = Location(1218, 1258)  -- 1st player S2
coords.arena_p2_s1 = Location(1882, 1138)  -- 2nd player S1
coords.arena_p3_s2 = Location(2781, 1256)  -- 3rd player S2
coords.arena_target_1 = Location(113, 172)  -- Target the 1st enemy
coords.arena_target_2 = Location(113, 383)  -- Target the 2nd enemy
coords.arena_target_3 = Location(113, 595)  -- Target the 3rd enemy
coords.arena_select_2 = Location(728, 706)  -- Select 2nd arena player
--endregion

-- Correct all locations before use
for name, location in pairs(coords) do
    coords[name] = utils.correct_location(location)
end

return coords
