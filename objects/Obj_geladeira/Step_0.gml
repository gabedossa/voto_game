// =============================================================
//  obj_geladeira — Step Event
// =============================================================
if (place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("Z")) && !global.dialog_active) {
        menu_open = !menu_open;
        obj_player.can_move = !menu_open;
    }
}

if (menu_open) {
    anim_t = min(1, anim_t + 0.12);
} else {
    anim_t = max(0, anim_t - 0.12);
}

if (keyboard_check_pressed(vk_escape) && menu_open) {
    menu_open           = false;
    obj_player.can_move = true;
}