// =============================================================
// scr_day_cycle.gml
// =============================================================

function day_cycle_init() {
    if (!variable_global_exists("day"))       { global.day = 1; }
    if (global.day < 1)                        { global.day = 1; }
    if (!variable_global_exists("hour"))      { global.hour = 6; }
    if (!variable_global_exists("minute"))    { global.minute = 0; }

    global.time_speed = 5;

    if (!variable_global_exists("time_timer")) { global.time_timer = 0; }
    if (!variable_global_exists("day_ended"))  { global.day_ended = false; }
    if (!variable_global_exists("energy_max")) { global.energy_max = 100; }
    if (!variable_global_exists("energy"))     { global.energy = global.energy_max; }
    if (!variable_global_exists("time_name"))  { global.time_name = "Manh" + chr(227); }
    if (!variable_global_exists("is_night"))   { global.is_night = false; }

    show_debug_message("DAY CYCLE INIT - DIA ATUAL: " + string(global.day));
}

function day_cycle_update() {
    if (global.day_ended) { exit; }

    global.time_timer++;

    if (global.time_timer >= global.time_speed) {
        global.time_timer = 0;
        global.minute += 1;

        if (global.minute >= 60) {
            global.minute = 0;
            global.hour++;

            if (global.hour >= 24) {
                end_day();
                exit;
            }
        }
    }

    if (global.hour < 12) {
        global.time_name = "Manh" + chr(227);
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

    if (global.day < 1) { global.day = 1; }
}

function get_light_overlay() {
    var _t = global.hour * 60 + global.minute;

    // ── Keyframes do dia: [minuto, alpha, cor_escurecimento, cor_tint, tint_amt] ──
    // A cor do escurecimento é sempre baseada no tom da noite, só muda a intensidade,
    // o que evita saltos de cor. O clima vem do tint.
    var _night_col = make_color_rgb(15, 25, 55);
    var _dawn_col  = make_color_rgb(255, 160, 110);
    var _noon_col  = make_color_rgb(255, 240, 200);
    var _dusk_col  = make_color_rgb(255, 130, 70);
    var _night_tint = make_color_rgb(50, 70, 130);

    // pontos: tempo (min), alpha, tint_color, tint_amt
    var _keys = [
        [0,    0.45, _night_tint, 0.20],  // meia-noite
        [300,  0.45, _night_tint, 0.20],  // 05:00 ainda noite
        [390,  0.20, _dawn_col,   0.14],  // 06:30 amanhecer
        [450,  0.0,  _dawn_col,   0.08],  // 07:30 manhã começando
        [600,  0.0,  _noon_col,   0.04],  // 10:00 manhã clara
        [780,  0.0,  _noon_col,   0.08],  // 13:00 início tarde
        [900,  0.0,  _noon_col,   0.16],  // 15:00 tarde quente
        [990,  0.18, _dusk_col,   0.28],  // 16:30 entardecer
        [1050, 0.35, _dusk_col,   0.32],  // 17:30 pôr do sol
        [1110, 0.45, _night_tint, 0.20],  // 18:30 noite
        [1440, 0.45, _night_tint, 0.20],  // 24:00 noite
    ];

    // ── Acha os dois keyframes que cercam o tempo atual e interpola ──
    var _n = array_length(_keys);
    var _i = 0;
    for (var k = 0; k < _n - 1; k++) {
        if (_t >= _keys[k][0] && _t < _keys[k + 1][0]) {
            _i = k;
            break;
        }
    }

    var _a_key = _keys[_i];
    var _b_key = _keys[_i + 1];

    var _span = _b_key[0] - _a_key[0];
    var _f = 0;
    if (_span > 0) {
        _f = smooth01((_t - _a_key[0]) / _span);
    }

    var _alpha    = lerp(_a_key[1], _b_key[1], _f);
    var _tint     = merge_color(_a_key[2], _b_key[2], _f);
    var _tint_amt = lerp(_a_key[3], _b_key[3], _f);

    // cor do escurecimento é sempre a noite (intensidade dada pelo alpha)
    var _col = _night_col;

    return { alpha: _alpha, color: _col, tint: _tint, tint_amt: _tint_amt };
}

function end_day() {
    if (global.day_ended) { exit; }

    global.day_ended = true;

    if (!variable_global_exists("day")) { global.day = 1; }
    if (global.day < 1)                  { global.day = 1; }

    var _sleep = asset_get_index("room_sleep_screen");

    if (_sleep >= 0) {
        room_goto(_sleep);
    } else {
        global.day += 1;
        global.energy     = global.energy_max;
        global.hour       = 6;
        global.minute     = 0;
        global.time_timer = 0;
        global.day_ended  = false;
        global.time_name  = "Manh" + chr(227);
        global.is_night   = false;

        show_debug_message("DORMIU - NOVO DIA: " + string(global.day));
    }
}

function get_time_string() {
    var _hour   = global.hour;
    var _minute = global.minute;

    var _m = string(floor(_minute));
    if (_minute < 10) { _m = "0" + _m; }

    var _h12 = _hour mod 12;
    if (_h12 == 0) { _h12 = 12; }

    var _p = "AM";
    if (_hour >= 12) { _p = "PM"; }

    return string(_h12) + ":" + _m + " " + _p;
}

function use_energy(_amount) {
    global.energy -= _amount;
    if (global.energy < 0) { global.energy = 0; }

    if (global.energy <= 0) {
        dialog_start("Luisa", [
            "Estou esgotada...",
            "Preciso descansar."
        ]);

        with (obj_game_manager) {
            alarm[0] = 120;
        }
    }
}

// =============================================================
// Função auxiliar — curva suave (ease in/out) para transições
// =============================================================
function smooth01(_x) {
    _x = clamp(_x, 0, 1);
    return _x * _x * (3 - 2 * _x);
}