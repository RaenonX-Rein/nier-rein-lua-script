utils = require(scriptPath() .. "mod/utils")

local images = {}

images.friend_icon = {
    path = "friend-icon.png";
    region = Region(2527, 58, 68, 56);
}

images.quest_type_indicator = {
    path = "quest-type.png";
    region = Region(2649, 1153, 48, 45);
}

images.quest_dark_mem_unit_indicator = {
    path = "dark-mem-unit.png";
    region = Region(270, 209, 37, 41);
}

images.quest_dark_mem_list_indicator = {
    path = "dark-mem-list.png";
    region = Region(551, 1142, 58, 51);
}

images.quest_dark_mem_complete_indicator = {
    path = "dark-mem-end.png";
    region = Region(2310, 1320, 67, 67);
}

images.quest_dark_mem_std_locked = {
    path = "dark-mem-lock.png";
    region = Region(2072, 312, 77, 80);
}

images.quest_dark_mem_exp_locked = {
    path = "dark-mem-lock.png";
    region = Region(2072, 569, 77, 80);
}

images.quest_dark_mem_exp_available = {
    path = "dark-mem-exp.png";
    region = Region(1925, 538, 57, 62);
}

images.quest_dark_mem_mst_locked = {
    path = "dark-mem-lock.png";
    region = Region(2072, 826, 77, 80);
}

images.quest_dark_mem_mst_available = {
    path = "dark-mem-mst.png";
    region = Region(1921, 793, 64, 62);
}

images.quest_wrong_indicator_pod = {
    path = "cancel-txt.png";
    region = Region(1794, 1184, 58, 64);
}

images.quest_ready_indicator = {
    path = "quest-txt.png";
    region = Region(1478, 118, 66, 68);
}

images.start_btn_border = {
    path = "btn-border.png";
    region = Region(1792, 1213, 49, 48);
}

images.unable_to_start_auto = {
    path = "auto-a-txt.png";
    region = Region(941, 690, 53, 59);
}

images.in_game_loop_icon = {
    path = "in-game-loop.png";
    region = Region(2218, 14, 44, 44);
}

images.in_game_2x_icon = {
    path = "in-game-2x.png";
    region = Region(2418, 20, 47, 56);
}

images.in_game_no_2x = {
    path = "in-game-no-2x.png";
    region = Region(2415, 18, 53, 60);
}

images.in_game_menu_back_btn = {
    path = "back-txt.png";
    region = Region(1424, 1250, 66, 62);
}

images.in_game_is_not_auto = {
    path = "not-auto-txt.png";
    region = Region(2627, 39, 45, 33);
}

images.in_game_wave_3 = {
    path = "wave-3.png";
    region = Region(2845, 127, 41, 51);
}

images.in_game_drop_ssr_0 = {
    path = "0-drop-txt.png";
    region = Region(1986, 342, 43, 53);
}

images.in_game_drop_ssr_1 = {
    path = "1-drop-txt.png";
    region = Region(1990, 341, 33, 53);
}

images.in_game_target_sergeant = {
    path = "target.png";
    region = Region(90, 385, 55, 46);
}

images.in_game_abort_confirm_txt = {
    path = "abort-txt.png";
    region = Region(1703, 635, 64, 68);
}

images.quest_complete_text = {
    path = "auto-left-txt.png";
    region = Region(1838, 1218, 48, 50);
}

images.result_loop_indicator = {
    path = "end-txt.png";
    region = Region(1427, 1250, 60, 60);
}

images.result_loop_end_indicator = {
    path = "more-txt.png";
    region = Region(2271, 1322, 52, 62);
}

images.result_single_indicator = {
    path = "more-txt.png";
    region = Region(2269, 1323, 54, 55);
}

images.ap_refill_indicator = {
    path = "ap-refill-txt.png";
    region = Region(1539, 118, 69, 71);
}

images.ap_refill_ap_potion_lg = {
    path = "ap-potion-lg-txt.png";
    region = Region(1496, 407, 72, 796);
}

images.ap_refill_confirm_indicator = {
    path = "confirm-txt.png";
    region = Region(1704, 1250, 62, 62);
}

images.ap_refill_refilled_indicator = {
    path = "close-txt.png";
    region = Region(1402, 1080, 64, 63);
}

images.arena_open_menu_text = {
    path = "arena-battle.png";
    region = Region(2289, 1061, 61, 67);
}

images.arena_start_battle_text = {
    path = "arena-start.png";
    region = Region(1704, 1249, 63, 64);
}

images.arena_pre_battle_wave = {
    path = "arena-wave.png";
    region = Region(2723, 130, 52, 46);
}

images.arena_in_battle_indicator = {
    path = "in-game-no-2x.png";
    region = Region(2415, 18, 53, 60);
}

images.arena_target_1 = {
    -- NOT a typo: target-2 means the 2nd type of image for target indicator
    path = "target-2.png";
    region = Region(125, 189, 21, 18);
}

images.arena_target_2 = {
    -- target-2 means the 2nd type of image for target indicator
    path = "target-2.png";
    region = Region(125, 401, 21, 18);
}

images.arena_target_3 = {
    -- NOT a typo: target-2 means the 2nd type of image for target indicator
    path = "target-2.png";
    region = Region(125, 614, 21, 18);
}

images.arena_dead_1 = {
    path = "arena-dead.png";
    region = Region(227, 185, 33, 24);
}

images.arena_dead_2 = {
    path = "arena-dead.png";
    region = Region(227, 397, 27, 33);
}

images.arena_dead_3 = {
    path = "arena-dead.png";
    region = Region(227, 607, 27, 33);
}

images.arena_battle_end = {
    path = "end-txt.png";
    region = Region(2107, 1065, 66, 57);
}

images.arena_bp_refill_txt = {
    path = "ap-refill-txt.png";
    region = Region(1453, 113, 90, 82);
}

images.arena_bp_fill_confirm_indicator = {
    path = "confirm-txt.png";
    region = Region(1701, 1248, 66, 63);
}

images.arena_bp_fill_complete_indicator = {
    path = "close-txt.png";
    region = Region(1399, 1083, 67, 60);
}

local arena_name_1 = Region(615, 430, 40, 41);

images.arena_avoid_1 = {
    path = "avoid-1.png";
    region = arena_name_1;
}

-- Correct all regions before use
for name, image in pairs(images) do
    images[name].region = utils.correct_region(image.region)
end

return images
