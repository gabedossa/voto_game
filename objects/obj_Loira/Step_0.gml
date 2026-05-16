if (instance_exists(obj_player)) {
    var _player = instance_nearest(x, y, obj_player);

    if (point_distance(x, y, _player.x, _player.y) <= 42) {
        if (keyboard_check_pressed(ord("Z")) && !global.dialog_active) {
            event_user(0);
        }
    }
}
