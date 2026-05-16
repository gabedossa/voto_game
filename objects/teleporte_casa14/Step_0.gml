if (place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("Z"))) {
        global.tp_x = target_x;
        global.tp_y = target_y;
        room_goto(target_room);
    }
}