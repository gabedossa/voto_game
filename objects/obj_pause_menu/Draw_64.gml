if (anim_t <= 0) exit;

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_bold");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_small");

draw_set_alpha(0.6 * anim_t);
draw_set_color(c_black);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

var _pw      = 350;
var _ph      = 360;
var _px      = _cx - _pw / 2;
var _py      = _cy - _ph / 2;
var _slide_y = (1 - anim_t) * 30;

// ── Fundo amadeirado ──────────────────────────────────────────
draw_set_alpha(0.95 * anim_t);
draw_set_color(make_color_rgb(100, 65, 30));
draw_roundrect(_px, _py + _slide_y, _px + _pw, _py + _ph + _slide_y, 14);

// Veios horizontais
draw_set_alpha(0.08 * anim_t);
for (var wy = 0; wy < _ph; wy += 5) {
    var _wood_color;

    if (wy mod 10 == 0) {
        _wood_color = make_color_rgb(60, 35, 10);
    } else {
        _wood_color = make_color_rgb(140, 95, 45);
    }

    draw_set_color(_wood_color);
    draw_rectangle(_px + 4, _py + _slide_y + wy, _px + _pw - 4, _py + _slide_y + wy + 2, false);
}

// Nós de madeira
draw_set_alpha(0.3 * anim_t);
// Nó 1 — canto superior esquerdo
draw_set_color(make_color_rgb(80, 40, 10));
draw_ellipse(_px + 20, _py + _slide_y + 80, _px + 60, _py + _slide_y + 115, false);
draw_set_color(make_color_rgb(60, 30, 8));
draw_ellipse(_px + 30, _py + _slide_y + 88, _px + 50, _py + _slide_y + 107, false);
draw_set_color(make_color_rgb(40, 20, 5));
draw_ellipse(_px + 36, _py + _slide_y + 94, _px + 44, _py + _slide_y + 101, false);

// Nó 2 — canto inferior direito
draw_set_color(make_color_rgb(80, 40, 10));
draw_ellipse(_px + _pw - 60, _py + _slide_y + _ph - 115, _px + _pw - 20, _py + _slide_y + _ph - 80, false);
draw_set_color(make_color_rgb(60, 30, 8));
draw_ellipse(_px + _pw - 50, _py + _slide_y + _ph - 107, _px + _pw - 30, _py + _slide_y + _ph - 88, false);
draw_set_color(make_color_rgb(40, 20, 5));
draw_ellipse(_px + _pw - 44, _py + _slide_y + _ph - 101, _px + _pw - 36, _py + _slide_y + _ph - 94, false);

// Nó 3 — lado direito meio
draw_set_color(make_color_rgb(80, 40, 10));
draw_ellipse(_px + _pw - 50, _py + _slide_y + 180, _px + _pw - 15, _py + _slide_y + 215, false);
draw_set_color(make_color_rgb(60, 30, 8));
draw_ellipse(_px + _pw - 42, _py + _slide_y + 188, _px + _pw - 23, _py + _slide_y + 207, false);
draw_set_color(make_color_rgb(40, 20, 5));
draw_ellipse(_px + _pw - 36, _py + _slide_y + 194, _px + _pw - 29, _py + _slide_y + 201, false);

// Borda dourada
draw_set_alpha(0.9 * anim_t);
draw_set_color(make_color_rgb(200, 150, 60));
draw_roundrect(_px, _py + _slide_y, _px + _pw, _py + _ph + _slide_y, 14);
draw_set_alpha(1);



// ── Título ────────────────────────────────────────────────────
draw_set_alpha(anim_t);
draw_set_halign(fa_center);

draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(255, 230, 150));
draw_text_transformed(_cx, _py + 28 + _slide_y, loc("pause_title"), 1.2, 1.2, 0);

draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(220, 190, 120));
draw_text_transformed(_cx, _py + 48 + _slide_y,
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
var _by_base = _py + 78 + _slide_y;

for (var i = 0; i < array_length(_items); i++) {
    var _by     = _by_base + i * (_btn_h + _btn_gap);
    var _active = (selected_option == i && is_open);

    var _alpha_btn;
    if (_active) { _alpha_btn = 0.85; } else { _alpha_btn = 0.3; }
    draw_set_alpha(_alpha_btn * anim_t);

    if (_active) {
        draw_set_color(make_color_rgb(180, 120, 40));
    } else {
        draw_set_color(make_color_rgb(80, 50, 20));
    }
    draw_roundrect(_bx, _by, _bx + _btn_w, _by + _btn_h, 6);

    if (_active) {
        draw_set_alpha(anim_t);
        draw_set_color(make_color_rgb(255, 200, 80));
        draw_roundrect(_bx, _by, _bx + _btn_w, _by + _btn_h, 6);
    }
    draw_set_alpha(1);

    draw_set_font(_fnt_normal);
    if (_active) {
        draw_set_color(make_color_rgb(255, 240, 180));
    } else {
        draw_set_color(make_color_rgb(180, 140, 80));
    }
    draw_set_alpha(anim_t);
    draw_text(_bx + 12, _by + (_btn_h / 2) - 8, _icons[i]);

    draw_set_font(_fnt_bold);
    if (_active) {
        draw_set_color(make_color_rgb(255, 240, 180));
    } else {
        draw_set_color(make_color_rgb(210, 170, 100));
    }
    draw_text_transformed(_cx, _by + (_btn_h / 2) - 8, _items[i], 1, 1, 0);
    draw_set_alpha(1);
}

// ── Hint ──────────────────────────────────────────────────────
draw_set_alpha(0.45 * anim_t);
draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(200, 160, 80));
draw_text_transformed(_cx, _py + _ph - 18 + _slide_y, "Esc  fechar", 1, 1, 0);
draw_set_alpha(1);
