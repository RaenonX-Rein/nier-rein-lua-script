utils = require(scriptPath() .. "mod/utils")

local coords = {}

--region Quest Select
-- Type
coords.quest_select_sub_quest = Location(1487, 618)  -- Sub-quest type
-- Dark Memories
coords.quest_select_dark_mem_std = Location(2107, 362)  -- Standard dark memory
coords.quest_select_dark_mem_exp = Location(2090, 637)  -- Expert dark memory
coords.quest_select_dark_mem_mst = Location(2090, 901)  -- Master dark memory
coords.quest_select_dark_mem = {
    -- Starts from index 1, and index 1 ~ 6 is top-left to top-right
    Location(931, 593),
    Location(1230, 593),
    Location(1568, 593),
    Location(1880, 593),
    Location(2183, 593),
    Location(2517, 593),
    Location(931, 1169),
    Location(1230, 1169),
    Location(1568, 1169),
    Location(1880, 1169),
    Location(2183, 1169),
    Location(2517, 1169),
}
coords.quest_select_dark_mem_back = Location(80, 80)

-- Actions
coords.quest_select_wrong_pod = Location(1918, 1215)  -- Click the cancel button if accidentally goes into pod page
--endregion

--region In Game
coords.in_game_target_sergeant = Location(116, 387)  -- Click to target the in_game_target_sergeant
coords.in_game_2x = Location(2457, 49)  -- In-game 2x icon location
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
coords.refill_by_gem = Location(1477, 522)  -- Click to refill by Gems
coords.refill_by_pot_sm = Location(1485, 553)  -- Click to refill by AP Potion S
coords.refill_by_pot_md = Location(1485, 817)  -- Click to refill by AP Potion M
coords.refill_by_pot_lg = Location(1485, 1075)  -- Click to refill by AP Potion L
coords.refill_add_item = Location(1923, 476)  -- Click to add items to consume
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
    if name == "quest_select_dark_mem" then
        for key, coord in pairs(location) do
            location[tonumber(key)] = utils.correct_location(coord)
        end
    else
        location = utils.correct_location(location)
    end

    coords[name] = location
end

return coords
