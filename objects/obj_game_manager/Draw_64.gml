// =============================================================
// DRAW GUI - obj_game_manager
// =============================================================

var _room_menu  = asset_get_index("room_main_menu");
var _room_sleep = asset_get_index("room_sleep_screen");

if (room != _room_menu && room != _room_sleep) {
    hud_draw();
    inventory_notif_draw();
}

if (variable_global_exists("dialog_active") && global.dialog_active) {
    dialog_draw();
}