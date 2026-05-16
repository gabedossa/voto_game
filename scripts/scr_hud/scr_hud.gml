// =============================================================
// scr_hud.gml
// =============================================================

function hud_draw() {
    var _fnt_bold  = asset_get_index("fnt_bold");
    var _fnt_small = asset_get_index("fnt_small");
    var _gui_h     = display_get_gui_height();

    if (!variable_global_exists("energy_max") || global.energy_max <= 0) {
        global.energy_max = 100;
    }

    if (!variable_global_exists("energy")) {
        global.energy = global.energy_max;
    }

    var _energy_pct = clamp(global.energy / global.energy_max, 0, 1);

    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var _panel_x = 20;
    var _panel_y = 20;
    var _panel_w = 210;
    var _panel_h = 112;

    draw_set_alpha(0.94);
    draw_set_color(make_color_rgb(92, 55, 26));
    draw_roundrect_ext(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, 8, 8, false);

    draw_set_alpha(0.12);
    for (var wy = 0; wy < _panel_h; wy += 6) {
        var _grain_color;

        if (wy mod 12 == 0) {
            _grain_color = make_color_rgb(55, 30, 12);
        } else {
            _grain_color = make_color_rgb(145, 92, 42);
        }

        draw_set_color(_grain_color);
        draw_rectangle(_panel_x + 6, _panel_y + wy, _panel_x + _panel_w - 6, _panel_y + wy + 2, false);
    }

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(205, 150, 62));
    draw_roundrect_ext(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, 8, 8, true);

    draw_set_alpha(0.45);
    draw_set_color(make_color_rgb(246, 206, 120));
    draw_roundrect_ext(_panel_x + 3, _panel_y + 3, _panel_x + _panel_w - 3, _panel_y + _panel_h - 3, 6, 6, true);

    draw_set_alpha(1);

    draw_set_color(make_color_rgb(255, 238, 196));
    draw_text(32, 32, "Dia: " + string(global.day));
    draw_text(32, 56, "Hora: " + get_time_string());
    draw_text(32, 80, "Periodo: " + string(global.time_name));
    draw_text(32, 104, "Dinheiro: $" + string(global.money));

    var _bar_x = 24;
    var _bar_w = 24;
    var _bar_h = 120;
    var _bar_y = _gui_h - _bar_h - 28;
    var _fill_h = floor((_bar_h - 8) * _energy_pct);
    var _fill_y = _bar_y + _bar_h - 4 - _fill_h;

    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_roundrect_ext(_bar_x - 6, _bar_y - 24, _bar_x + _bar_w + 8, _bar_y + _bar_h + 28, 8, 8, false);

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(80, 55, 30));
    draw_roundrect_ext(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, 6, 6, false);

    draw_set_color(make_color_rgb(230, 180, 70));
    draw_roundrect_ext(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, 6, 6, true);

    var _energy_color = make_color_rgb(80, 220, 110);

    if (_energy_pct <= 0.25) {
        _energy_color = make_color_rgb(230, 70, 55);
    }
    else if (_energy_pct <= 0.5) {
        _energy_color = make_color_rgb(235, 190, 55);
    }

    if (variable_global_exists("player_running") && global.player_running) {
        _energy_color = make_color_rgb(255, 255, 0);
    }

    draw_set_color(_energy_color);
    draw_rectangle(_bar_x + 4, _fill_y, _bar_x + _bar_w - 4, _bar_y + _bar_h - 4, false);

    draw_set_font(_fnt_bold);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_bar_x + _bar_w / 2, _bar_y - 20, "EN");

    draw_set_font(_fnt_small);
    draw_set_halign(fa_center);
    draw_text(_bar_x + _bar_w / 2, _bar_y + _bar_h + 8, string(floor(global.energy)));

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
