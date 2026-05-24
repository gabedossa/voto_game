// =============================================================
// scr_dialog.gml
// =============================================================

function dialog_init() {

    global.dialog_active  = false;
    global.dialog_lines   = [];
    global.dialog_queue   = [];
    global.dialog_index   = 0;

    global.dialog_speaker = "";
    global.dialog_text    = "";

    global.dialog_char    = 0;
    global.dialog_speed   = 2;

    global.dialog_done    = false;
}

// =============================================================

function dialog_start(_speaker, _lines) {

    if (!variable_global_exists("dialog_active")) {
        dialog_init();
    }

    if (!variable_global_exists("dialog_queue")) {
        global.dialog_queue = [];
    }

    if (global.dialog_active) {
        array_push(global.dialog_queue, {
            speaker: _speaker,
            lines: _lines
        });

        exit;
    }

    global.dialog_active  = true;
    global.dialog_lines   = _lines;
    global.dialog_index   = 0;

    global.dialog_speaker = _speaker;

    global.dialog_text    = "";
    global.dialog_char    = 0;

    global.dialog_done    = false;

    if (instance_exists(obj_player)) {

        with (obj_player) {
            can_move = false;
        }
    }
}

// =============================================================

function dialog_update() {

    if (!global.dialog_active) {
        exit;
    }

    if (!global.dialog_done) {

        global.dialog_char += global.dialog_speed;

        var _full =
        global.dialog_lines[global.dialog_index];

        global.dialog_text =
        string_copy(
            _full,
            1,
            floor(global.dialog_char)
        );

        if (
            global.dialog_char
            >= string_length(_full)
        ) {

            global.dialog_text = _full;
            global.dialog_done = true;
        }
    }

    if (
        keyboard_check_pressed(vk_space)
        || keyboard_check_pressed(vk_enter)
    ) {

        if (!global.dialog_done) {

            global.dialog_text =
            global.dialog_lines[global.dialog_index];

            global.dialog_done = true;
        }
        else {

            global.dialog_index++;

            if (
                global.dialog_index
                >= array_length(global.dialog_lines)
            ) {

                dialog_close();
            }
            else {

                global.dialog_char = 0;
                global.dialog_done = false;
                global.dialog_text = "";
            }
        }
    }
}

// =============================================================

function dialog_draw() {

    if (!global.dialog_active) {
        exit;
    }

    var _fnt_bold   = asset_get_index("fnt_normal");
    var _fnt_normal = asset_get_index("fnt_normal");
    var _fnt_small  = asset_get_index("fnt_normal");

    var _W = display_get_gui_width();
    var _H = display_get_gui_height();

    var _bx = 16;
    var _by = _H - 130;

    var _bw = _W - 32;
    var _bh = 118;

    // Fundo
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(100, 65, 30));

    draw_rectangle(
        _bx,
        _by,
        _bx + _bw,
        _by + _bh,
        false
    );

    // Borda externa
    draw_set_alpha(1);

    draw_set_color(
        make_color_rgb(200, 150, 60)
    );

    draw_roundrect(
        _bx,
        _by,
        _bx + _bw,
        _by + _bh,
        8
    );

    // Borda interna
    draw_set_color(
        make_color_rgb(240, 200, 100)
    );

    draw_roundrect(
        _bx + 3,
        _by + 3,
        _bx + _bw - 3,
        _by + _bh - 3,
        6
    );

    // Nome
    draw_set_font(_fnt_bold);

    draw_set_color(
        make_color_rgb(255, 230, 120)
    );

    draw_text(
        _bx + 14,
        _by + 8,
        global.dialog_speaker
    );

    // Texto
    draw_set_font(_fnt_normal);

    draw_set_color(
        make_color_rgb(255, 240, 200)
    );

    draw_text_ext(
        _bx + 14,
        _by + 30,
        global.dialog_text,
        24,
        _bw - 28
    );

    // Hint
    if (global.dialog_done) {

        draw_set_font(_fnt_small);

        draw_set_color(c_white);

        draw_text(
            _bx + 25,
            _by + _bh - 30,
            "[ ESPACO / ENTER ]"
        );
    }
}

// =============================================================

function dialog_close() {

    if (
        variable_global_exists("dialog_queue")
        && array_length(global.dialog_queue) > 0
    ) {
        var _next = global.dialog_queue[0];
        array_delete(global.dialog_queue, 0, 1);

        global.dialog_active = false;
        dialog_start(_next.speaker, _next.lines);

        exit;
    }

    global.dialog_active  = false;
    global.dialog_lines   = [];

    global.dialog_index   = 0;

    global.dialog_text    = "";
    global.dialog_speaker = "";

    global.dialog_char    = 0;
    global.dialog_done    = false;

    if (instance_exists(obj_player)) {

        with (obj_player) {
            can_move = true;
        }
    }
}
