if (flag_get("iniciar_minigame")) {

    flag_set("iniciar_minigame", false);
    flag_set("missao1_filmagem", true);

    global.tp_x = 95;
    global.tp_y = 576;

    room_goto(rm_room_minigame);
}