// =============================================================
// scr_day_cycle.gml
// =============================================================

function day_cycle_init() {
    if (!variable_global_exists("day")) {
        global.day = 1;
    }

    if (global.day < 1) {
        global.day = 1;
    }

    if (!variable_global_exists("hour")) {
        global.hour = 6;
    }

    if (!variable_global_exists("minute")) {
        global.minute = 0;
    }

    global.time_speed = 60;

    if (!variable_global_exists("time_timer")) {
        global.time_timer = 0;
    }

    if (!variable_global_exists("day_ended")) {
        global.day_ended = false;
    }

    if (!variable_global_exists("energy_max")) {
        global.energy_max = 100;
    }

    if (!variable_global_exists("energy")) {
        global.energy = global.energy_max;
    }

    if (!variable_global_exists("time_name")) {
        global.time_name = "Manh" + chr(227);
    }

    if (!variable_global_exists("is_night")) {
        global.is_night = false;
    }

    show_debug_message("DAY CYCLE INIT - DIA ATUAL: " + string(global.day));
}

function day_cycle_update() {
    if (global.day_ended) {
        exit;
    }

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

    if (global.day < 1) {
        global.day = 1;
    }
}

function end_day() {
    if (global.day_ended) {
        exit;
    }

    global.day_ended = true;

    if (!variable_global_exists("day")) {
        global.day = 1;
    }

    if (global.day < 1) {
        global.day = 1;
    }

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

    if (_minute < 10) {
        _m = "0" + _m;
    }

    var _h12 = _hour mod 12;

    if (_h12 == 0) {
        _h12 = 12;
    }

    var _p = "AM";

    if (_hour >= 12) {
        _p = "PM";
    }

    return string(_h12) + ":" + _m + " " + _p;
}

function use_energy(_amount) {
    global.energy -= _amount;

    if (global.energy < 0) {
        global.energy = 0;
    }

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
