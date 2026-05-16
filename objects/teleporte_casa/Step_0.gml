if (place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("Z"))) {
        show_debug_message("Indo para room: " + string(target_room) + " nome: " + room_get_name(target_room));
        with (obj_player) {
            x = other.target_x;
            y = other.target_y;
        }
        room_goto(target_room);
    }
}