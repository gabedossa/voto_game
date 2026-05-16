if (place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("Z")) && !global.dialog_active) {
        event_user(0);
    }
}