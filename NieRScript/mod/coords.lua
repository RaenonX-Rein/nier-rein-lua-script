local coords = {}

--region Quest Select
-- Dark Memories (DarkMem)
coords.quest_select_dark_mem_coin_1 = Location(2076, 638)  -- Trade coin quest (DarkMem/Coin-1)
coords.quest_select_dark_mem_ticket_1 = Location(2076, 907)  -- Scout ticket quest (DarkMem/Ticket-1)
coords.quest_select_dark_mem_coin_2 = Location(2087, 816)  -- Trade coin quest (DarkMem/Coin-2)
coords.quest_select_dark_mem_ticket_2 = Location(2087, 1080)  -- Trade coin quest (DarkMem/Coin-2)
coords.quest_select_dark_mem_swipe_1 = Location(2092, 1090)  -- Starting point of the swipe on the dark mem menu
coords.quest_select_dark_mem_swipe_2 = Location(2092, 340)  -- Ending point of the swipe on the dark mem menu
-- Main quest
coords.quest_select_main_9 = Location(2116, 984)
coords.quest_select_main_10 = Location(2487, 981)
-- Event
coords.quest_select_event_difficulty = Location(2515, 251)  -- Click for switching the difficulty
coords.quest_select_event_list_swipe_1 = Location(2092, 1090)  -- Starting point of the swipe on the event menu
coords.quest_select_event_list_swipe_2 = Location(2092, 360)  -- Ending point of the swipe on the event menu
coords.quest_select_event_vh_9 = Location(2107, 815)  -- Quest 9 button location
coords.quest_select_event_vh_10 = Location(2114, 1100)  -- Quest 10 button location
-- Others
coords.quest_select_week_rot = Location(2077, 1089)  -- Weekly rotating sub-quest
--endregion

--region Quest Control
coords.quest_start_btn = Location(1757, 1281)  -- Quest start button

coords.quest_result_loop_close = Location(1485, 1279)  -- Close the loop result dialog
coords.quest_result_single_close = Location(2367, 1354)  -- Close the single result dialog

coords.quest_result_single_continue = Location(1803, 1312)  -- Continue (skip the wait)
--endregion

--region AP Refill
coords.refill_quest_ready = Location(1981, 1161)  -- "+" button for AP refill in quest ready page
coords.refill_by_gem = Location(1477, 522)  -- Click to refill by Gem
coords.refill_confirm = Location(1760, 1282)  -- Confirm AP refill
coords.refill_filled_close = Location(1484, 1115)  -- Close the AP filled dialog
--endregion

return coords
