switch (phase) {
    case "fade_in":
        anim_t += 0.03;
        if (anim_t >= 1) {
            anim_t = 1;
            phase  = "show";
        }
    break;

    case "show":
        show_timer++;
        if (show_timer >= 60) {
            if (keyboard_check_pressed(ord("Z"))) {
                phase = "fade_out";
            }
        }
    break;

    case "fade_out":
        fade_out_t += 0.04;
        if (fade_out_t >= 1) {
            global.tp_x = 162;
            global.tp_y = 485;
            var _ow = asset_get_index("room_house_luisa");
            if (_ow >= 0) room_goto(_ow);
        }
    break;
}