// =============================================================
// scr_save_load.gml
// Salvar e carregar progresso do jogo em JSON
// =============================================================

function flags_init() {
    if (!variable_global_exists("flags") || is_undefined(global.flags)) {
        global.flags = {};
    }
}

function flag_get(_key) {
    flags_init();

    var _value = global.flags[$ _key];
    if (is_undefined(_value)) return false;

    return _value;
}

function flag_set(_key, _value) {
    flags_init();
    global.flags[$ _key] = _value;
}

function save_game() {
    var _map = ds_map_create();

    if (!variable_global_exists("inventory") || is_undefined(global.inventory)) {
        global.inventory = [];
    }

    flags_init();

    ds_map_add(_map, "day", global.day);
    ds_map_add(_map, "hour", global.hour);
    ds_map_add(_map, "minute", global.minute);
    ds_map_add(_map, "money", global.money);
    ds_map_add(_map, "energy", global.energy);

    var _player_x = 0;
    var _player_y = 0;

    if (instance_exists(obj_player)) {
        _player_x = obj_player.x;
        _player_y = obj_player.y;
    } else if (
        variable_global_exists("tp_x")
        && variable_global_exists("tp_y")
        && !is_undefined(global.tp_x)
        && !is_undefined(global.tp_y)
    ) {
        _player_x = global.tp_x;
        _player_y = global.tp_y;
    }

    ds_map_add(_map, "player_x", _player_x);
    ds_map_add(_map, "player_y", _player_y);

    var _inv = "";
    for (var i = 0; i < array_length(global.inventory); i++) {
        _inv += global.inventory[i] + ",";
    }
    ds_map_add(_map, "inventory", _inv);

    var _flags_str = "";
    var _keys = variable_struct_get_names(global.flags);
    for (var i = 0; i < array_length(_keys); i++) {
        if (global.flags[$ _keys[i]]) {
            _flags_str += _keys[i] + ",";
        }
    }
    ds_map_add(_map, "flags", _flags_str);

    var _json = json_encode(_map);
    var _file = file_text_open_write("save.json");
    file_text_write_string(_file, _json);
    file_text_close(_file);
    ds_map_destroy(_map);

    var _sleep = asset_get_index("room_sleep_screen");
    if (room != _sleep) {
        dialog_start("Sistema", ["Jogo salvo!"]);
    }
}

function load_game() {
    if (!file_exists("save.json")) return false;

    var _file = file_text_open_read("save.json");
    var _json = file_text_read_string(_file);
    file_text_close(_file);

    var _map = json_decode(_json);

    if (ds_map_exists(_map, "day")) {
        global.day = _map[? "day"];
    } else {
        global.day = 1;
    }

    if (ds_map_exists(_map, "money")) {
        global.money = _map[? "money"];
    } else {
        global.money = 500;
    }

    if (ds_map_exists(_map, "energy")) {
        global.energy = _map[? "energy"];
    } else {
        global.energy = global.energy_max;
    }

    if (ds_map_exists(_map, "hour")) {
        global.hour = _map[? "hour"];
    } else {
        global.hour = 6;
    }

    if (ds_map_exists(_map, "minute")) {
        global.minute = _map[? "minute"];
    } else {
        global.minute = 0;
    }

    global.time_timer = 0;
    global.day_ended = false;

    if (global.hour < 12) {
        global.time_name = "Manha";
        global.is_night = false;
    }
    else if (global.hour < 18) {
        global.time_name = "Tarde";
        global.is_night = false;
    }
    else {
        global.time_name = "Noite";
        global.is_night = true;
    }

    var _player_x = 224;
    var _player_y = 992;

    if (ds_map_exists(_map, "player_x")) {
        _player_x = _map[? "player_x"];
    }

    if (ds_map_exists(_map, "player_y")) {
        _player_y = _map[? "player_y"];
    }

    global.tp_x = _player_x;
    global.tp_y = _player_y;

    if (instance_exists(obj_player)) {
        with (obj_player) {
            x = global.tp_x;
            y = global.tp_y;
        }
    }

    global.inventory = [];
    var _inv = "";
    if (ds_map_exists(_map, "inventory")) {
        _inv = _map[? "inventory"];
    }
    if (_inv != "") {
        var _parts = string_split(_inv, ",");
        for (var i = 0; i < array_length(_parts) - 1; i++) {
            array_push(global.inventory, _parts[i]);
        }
    }

    global.flags = {};
    var _flags_str = "";
    if (ds_map_exists(_map, "flags")) {
        _flags_str = _map[? "flags"];
    }
    if (_flags_str != "") {
        var _fparts = string_split(_flags_str, ",");
        for (var i = 0; i < array_length(_fparts) - 1; i++) {
            global.flags[$ _fparts[i]] = true;
        }
    }

    ds_map_destroy(_map);
    return true;
}
