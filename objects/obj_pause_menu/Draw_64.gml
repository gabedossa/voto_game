if (anim_t <= 0) exit;

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_normal");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_normal");

// ── Overlay escuro de fundo ───────────────────────────────────
draw_set_alpha(0.6 * anim_t);
draw_set_color(c_black);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

var _pw      = 350;
var _ph      = 360;
var _px      = _cx - _pw / 2;
var _py      = _cy - _ph / 2;
var _slide_y = (1 - anim_t) * 30;
var _top     = _py + _slide_y;

// ── Sombra do painel ──────────────────────────────────────────
draw_set_alpha(0.3 * anim_t);
draw_set_color(c_black);
draw_roundrect_ext(_px + 6, _top + 8, _px + _pw + 6, _top + _ph + 8, 16, 16, false);
draw_set_alpha(1);

// ── Fundo pergaminho liso (OPACO e PREENCHIDO) ────────────────
draw_set_alpha(1);
draw_set_color(make_color_rgb(238, 222, 186));
draw_roundrect_ext(_px, _top, _px + _pw, _top + _ph, 16, 16, false);

// ── Bordas (true = só contorno) ───────────────────────────────
draw_set_color(make_color_rgb(120, 85, 45));
draw_roundrect_ext(_px, _top, _px + _pw, _top + _ph, 16, 16, true);
draw_set_color(make_color_rgb(190, 150, 90));
draw_roundrect_ext(_px + 4, _top + 4, _px + _pw - 4, _top + _ph - 4, 13, 13, true);

// ── Título ────────────────────────────────────────────────────
draw_set_halign(fa_center);

draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(200, 175, 130));
draw_text_transformed(_cx + 1, _top + 29, loc("pause_title"), 1.3, 1.3, 0);
draw_set_color(make_color_rgb(90, 60, 30));
draw_text_transformed(_cx, _top + 28, loc("pause_title"), 1.3, 1.3, 0);

draw_set_color(make_color_rgb(150, 115, 70));
draw_line(_px + 40, _top + 62, _px + _pw - 40, _top + 62);

draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(110, 85, 50));
draw_text_transformed(_cx, _top + 68,
    loc("hud_day") + " " + string(global.day) + "   " + get_time_string(), 1, 1, 0);

draw_set_halign(fa_left);

// ── Itens ─────────────────────────────────────────────────────
var _items = [
    loc("pause_resume"),
    loc("pause_save"),
    loc("pause_settings"),
    loc("pause_main_menu"),
    loc("pause_quit")
];
var _icons   = [">", "$", "*", "^", "X"];
var _btn_h   = 42;
var _btn_gap = 6;
var _btn_w   = _pw - 40;
var _bx      = _px + 20;
var _by_base = _top + 92;

for (var i = 0; i < array_length(_items); i++) {
    var _by     = _by_base + i * (_btn_h + _btn_gap);
    var _active = (selected_option == i && is_open);

    if (_active) {
        draw_set_color(make_color_rgb(210, 160, 70));
        draw_roundrect_ext(_bx, _by, _bx + _btn_w, _by + _btn_h, 8, 8, false);
        draw_set_color(make_color_rgb(170, 120, 50));
        draw_roundrect_ext(_bx, _by, _bx + _btn_w, _by + _btn_h, 8, 8, true);
    } else {
        draw_set_color(make_color_rgb(220, 202, 165));
        draw_roundrect_ext(_bx, _by, _bx + _btn_w, _by + _btn_h, 8, 8, false);
        draw_set_color(make_color_rgb(170, 140, 95));
        draw_roundrect_ext(_bx, _by, _bx + _btn_w, _by + _btn_h, 8, 8, true);
    }

    draw_set_font(_fnt_normal);
    if (_active) {
        draw_set_color(make_color_rgb(255, 245, 215));
    } else {
        draw_set_color(make_color_rgb(120, 90, 55));
    }
    draw_text(_bx + 14, _by + (_btn_h / 2) - 8, _icons[i]);

    draw_set_font(_fnt_bold);
    if (_active) {
        draw_set_color(make_color_rgb(255, 250, 230));
    } else {
        draw_set_color(make_color_rgb(95, 65, 35));
    }
    draw_set_halign(fa_center);
    draw_text_transformed(_cx, _by + (_btn_h / 2) - 8, _items[i], 1, 1, 0);
    draw_set_halign(fa_left);
}

// ── Hint ──────────────────────────────────────────────────────
draw_set_halign(fa_center);
draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(130, 100, 60));
draw_text_transformed(_cx, _top + _ph - 18, "Esc  fechar", 1, 1, 0);
draw_set_halign(fa_left);
draw_set_alpha(1);