utils = require(scriptPath() .. "mod/utils")

local images = {}

images.friend_icon = {
    path = "friend-icon.png";
    region = Region(2527, 58, 68, 56);
}

images.quest_event_vh_difficulty_text = {
    path = "quest-vh.png";
    region = Region(2408, 226, 54, 47);
}

images.quest_event_3_text = {
    path = "3-txt.png";
    region = Region(1822, 301, 92, 932);
}

images.quest_event_9_text = {
    path = "9-txt.png";
    region = Region(1822, 301, 92, 932);
}

images.quest_dark_mem_2_coin_text = {
    path = "coin-txt.png";
    region = Region(1800, 783, 61, 53);
}

images.quest_event_vh_quest_10_text = {
    path = "1-txt.png";
    region = Region(1843, 1021, 45, 64);
}

images.quest_mem_10_text = {
    path = "mem-10f-txt.png";
    region = Region(1728, 322, 74, 921);
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

images.in_game_menu_back_btn = {
    path = "back-txt.png";
    region = Region(1424, 1250, 66, 62);
}

images.in_game_is_not_auto = {
    path = "not-auto-txt.png";
    region = Region(2627, 39, 45, 33);
}

images.in_game_is_auto = {
    path = "auto-txt.png";
    region = Region(2625, 39, 47, 34);
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
    region = Region(1402, 1080, 64, 63)
}

-- Correct all regions before use
for name, image in pairs(images) do
    images[name].region = utils.correct_region(image.region)
end

return images
