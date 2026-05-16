if (place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("Z")) && !global.dialog_active && !global.confirmar_dormir && !global.game_paused) {
        dialog_start("Luisa", [
            "Estou cansada...",
            "Vou dormir agora."
        ]);
        global.confirmar_dormir = true;
    }
}

if (global.confirmar_dormir && !global.dialog_active) {
    global.confirmar_dormir = false;
    var _sleep = asset_get_index("room_sleep_screen");
    if (_sleep >= 0) {
        room_goto(_sleep);
    } else {
        show_debug_message("ERRO: room_sleep_screen nao encontrada!");
    }
}