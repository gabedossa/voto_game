// =============================================================
// ROOM START - obj_player
// =============================================================

var _has_tp_x = variable_global_exists("tp_x") && !is_undefined(global.tp_x);
var _has_tp_y = variable_global_exists("tp_y") && !is_undefined(global.tp_y);

if (_has_tp_x) {
    x = global.tp_x;
}

if (_has_tp_y) {
    y = global.tp_y;
}

if (room == rm_room_minigame && (!_has_tp_x || !_has_tp_y)) {
    x = 95;
    y = 576;
}

show_debug_message(
    "PLAYER ENTROU EM: "
    + room_get_name(room)
    + " | DIA: "
    + string(global.day)
);

global.tp_x = undefined;
global.tp_y = undefined;
