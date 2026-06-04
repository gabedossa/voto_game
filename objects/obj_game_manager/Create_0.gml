// =============================================================
// CREATE - obj_game_manager
// =============================================================

persistent = true;

// Se já existe mais de um obj_game_manager, destrói o duplicado
if (instance_number(obj_game_manager) > 1) {
    show_debug_message("GAME MANAGER DUPLICADO DESTRUIDO");
    instance_destroy();
    exit;
}

// =============================================================
// GLOBAIS PRINCIPAIS
// =============================================================

if (!variable_global_exists("day")) {
    global.day = 1;
}

if (global.day < 1) {
    global.day = 1;
}

if (!variable_global_exists("money")) {
    global.money = 500;
}

if (!variable_global_exists("flags")) {
    global.flags = {};
}

if (!variable_global_exists("game_paused")) {
    global.game_paused = false;
}

if (!variable_global_exists("inventory_open")) {
    global.inventory_open = false;
}

if (!variable_global_exists("confirmar_dormir")) {
    global.confirmar_dormir = false;
}

if (!variable_global_exists("tp_x")) {
    global.tp_x = undefined;
}

if (!variable_global_exists("tp_y")) {
    global.tp_y = undefined;
}

// =============================================================
// INICIALIZA SISTEMAS SEM RESETAR O DIA
// =============================================================

dialog_init();
day_cycle_init();
inventory_init();
language_init();

// =============================================================
// PREFERÊNCIAS
// =============================================================

var _prefs = load_prefs();

if (!is_undefined(_prefs)) {
    if (!is_undefined(_prefs[$ "language"])) {
        global.language = _prefs[$ "language"];
    }
}

// =============================================================
// MÚSICA
// =============================================================

audio_stop_all();

var _snd = asset_get_index("snd_game_theme");

if (room == rm_overworld && _snd >= 0) {
    audio_play_sound(_snd, 1, true);
}

show_debug_message("GAME MANAGER CRIADO - DIA ATUAL: " + string(global.day));
window_set_fullscreen(true);