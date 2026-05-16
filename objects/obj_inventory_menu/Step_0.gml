if (keyboard_check_pressed(ord("E")) && !is_open && !global.game_paused) {
    if (!global.dialog_active) {
        is_open               = true;
        global.inventory_open = true;
        obj_player.can_move   = false;
        selected_option       = 0;
        selected_cat          = 0;
        exit;
    }
}

if (!is_open) {
    anim_t = max(0, anim_t - 0.12);
    exit;
}

anim_t = min(1, anim_t + 0.12);



if (keyboard_check_pressed(vk_escape)) {
    is_open               = false;
    global.inventory_open = false;
    obj_player.can_move   = true;
    exit;
}

if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")))
    selected_cat = (selected_cat + 1) mod array_length(categories);
if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")))
    selected_cat = (selected_cat - 1 + array_length(categories)) mod array_length(categories);

var _itens_cat = [];
for (var i = 0; i < array_length(global.inventory); i++) {
    if (string_pos(categories[selected_cat], global.inventory[i]) > 0) {
        array_push(_itens_cat, global.inventory[i]);
    }
}

if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")))
    selected_option = (selected_option + 1) mod max(1, array_length(_itens_cat));
if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")))
    selected_option = (selected_option - 1 + max(1, array_length(_itens_cat))) mod max(1, array_length(_itens_cat));