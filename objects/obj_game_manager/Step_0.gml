// =============================================================
// STEP - obj_game_manager
// =============================================================

if (!variable_global_exists("day")) {
    global.day = 1;
}

if (global.day < 1) {
    global.day = 1;
}

// =============================================================
// DEBUG - DESCOBRIR QUANDO O DIA MUDA
// =============================================================

if (!variable_global_exists("debug_last_day")) {
    global.debug_last_day = global.day;
}

if (global.day != global.debug_last_day) {
    show_debug_message(
        "DIA MUDOU DE "
        + string(global.debug_last_day)
        + " PARA "
        + string(global.day)
        + " NA ROOM: "
        + room_get_name(room)
    );

    global.debug_last_day = global.day;
}

// =============================================================
// ATUALIZA SISTEMAS
// =============================================================

var _room_menu  = asset_get_index("room_main_menu");
var _room_sleep = asset_get_index("room_sleep_screen");

if (!global.game_paused && room != _room_menu && room != _room_sleep) {
    day_cycle_update();
}

if (variable_global_exists("dialog_active") && global.dialog_active) {
    dialog_update();
}
