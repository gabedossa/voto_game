var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_bold");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_small");

var _alpha;
if (phase == "fade_out") {
    _alpha = 1 - fade_out_t;
} else {
    _alpha = anim_t;
}

// ── Fundo noturno ─────────────────────────────────────────────
draw_set_alpha(_alpha);
draw_set_color(make_color_rgb(5, 8, 20));
draw_rectangle(0, 0, _W, _H, false);

// Estrelas
randomise();
for (var i = 0; i < 60; i++) {
    var _sx = (i * 137.5) mod _W;
    var _sy = (i * 97.3)  mod (_H * 0.7);
    var _ss;
    if ((i mod 3) == 0) { _ss = 2; } else { _ss = 1; }
    var _sa = (sin(current_time * 0.003 + i) * 0.3 + 0.7);
    draw_set_alpha(_alpha * _sa * 0.8);
    draw_set_color(c_white);
    draw_circle(_sx, _sy, _ss, false);
}
draw_set_alpha(1);

// Lua
draw_set_alpha(_alpha * 0.9);
draw_set_color(make_color_rgb(240, 235, 200));
draw_circle(_W * 0.75, _H * 0.2, 28, false);
draw_set_color(make_color_rgb(5, 8, 20));
draw_circle(_W * 0.75 + 10, _H * 0.2 - 5, 22, false);

// ── Painel estilo menu principal ──────────────────────────────
var _slide = (1 - anim_t) * 40;

// Fundo verde escuro
draw_set_alpha(_alpha * 0.95);
draw_set_color(make_color_rgb(15, 30, 20));
draw_roundrect(_cx - 200, _cy - 80 + _slide, _cx + 200, _cy + 120 + _slide, 16);

// Gradiente interno
for (var wy = 0; wy < 200; wy += 5) {
    var _ga = (1 - wy / 200) * 0.25 * _alpha;
    draw_set_alpha(_ga);
    draw_set_color(make_color_rgb(40, 80, 50));
    draw_rectangle(_cx - 196, _cy - 80 + _slide + wy, _cx + 196, _cy - 80 + _slide + wy + 4, false);
}

// Borda verde
draw_set_alpha(0.9 * _alpha);
draw_set_color(make_color_rgb(70, 140, 80));
draw_roundrect(_cx - 200, _cy - 80 + _slide, _cx + 200, _cy + 120 + _slide, 16);
draw_set_alpha(1);

// ── Textos ────────────────────────────────────────────────────
draw_set_alpha(_alpha);
draw_set_halign(fa_center);

draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(180, 240, 160));
draw_text_transformed(_cx, _cy - 55 + _slide, loc("sleep_title"), 1.3, 1.3, 0);

draw_set_font(_fnt_normal);
draw_set_color(make_color_rgb(240, 200, 100));
draw_text_transformed(_cx, _cy - 15 + _slide,
    loc("sleep_day") + " " + string(global.day), 1.1, 1.1, 0);

draw_set_color(make_color_rgb(120, 220, 140));
draw_text_transformed(_cx, _cy + 15 + _slide,
    loc("hud_energy") + ": " + string(global.energy_max) + " / " + string(global.energy_max), 1, 1, 0);

if (saved_msg) {
    draw_set_font(_fnt_small);
    draw_set_color(make_color_rgb(100, 200, 100));
    draw_text_transformed(_cx, _cy + 45 + _slide, "ok  " + loc("sleep_saved"), 1, 1, 0);
}

if (phase == "show" && show_timer >= 60) {
    var _pulse = abs(sin(current_time * 0.005)) * 0.5 + 0.5;
    draw_set_alpha(_alpha * _pulse);
    draw_set_font(_fnt_small);
    draw_set_color(make_color_rgb(150, 200, 130));
    draw_text_transformed(_cx, _cy + 90 + _slide, "[ Z ]  Continuar", 1, 1, 0);
}

draw_set_halign(fa_left);
draw_set_alpha(1);