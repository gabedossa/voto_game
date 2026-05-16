if (flag_get("iniciar_minigame") && !global.dialog_active) {

    flag_set("iniciar_minigame", false);
    flag_set("missao1_filmagem", true);

    if (instance_exists(obj_player)) {
        with (obj_player) {
            can_move = true;
            spd_x = 0;
            spd_y = 0;
        }
    }

    global.tp_x = 95;
    global.tp_y = 576;

    room_goto(rm_room_minigame);
}
