// =============================================================
//  obj_geladeira — Draw GUI Event
// =============================================================
if (anim_t <= 0) exit;

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_bold");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_small");

var _borda = make_color_rgb(200, 150, 60);
var _fundo = make_color_rgb(117, 66, 55);
var _raio  = 4;
var _pw    = 320;
var _ph    = 200;
var _px    = _cx - _pw / 2;
var _py    = _cy - _ph / 2;
var _sl    = (1 - anim_t) * 30;

// Overlay
draw_set_alpha(0.5 * anim_t);
draw_set_color(c_black);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

// Fundo amadeirado
draw_set_alpha(0.95 * anim_t);
draw_set_color(_fundo);
draw_rectangle(_px, _py + _sl, _px + _pw, _py + _ph + _sl, false);

// Veios
draw_set_alpha(0.08 * anim_t);
for (var wy = 0; wy < _ph; wy += 5) {
    var _wood_color;

    if (wy mod 10 == 0) {
        _wood_color = make_color_rgb(60, 35, 10);
    } else {
        _wood_color = make_color_rgb(140, 95, 45);
    }

    draw_set_color(_wood_color);
    draw_rectangle(_px + 4, _py + _sl + wy, _px + _pw - 4, _py + _sl + wy + 2, false);
}

// Borda dourada
draw_set_alpha(0.9 * anim_t);
draw_set_color(_borda);
draw_roundrect(_px, _py + _sl, _px + _pw, _py + _ph + _sl, _raio);
draw_set_alpha(1);

// Título
draw_set_alpha(anim_t);
draw_set_color(_fundo);
draw_rectangle(_px, _py + _sl, _px + _pw, _py + _sl + 36, false);
draw_set_color(_borda);
draw_roundrect(_px, _py + _sl, _px + _pw, _py + _sl + 36, _raio);
draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(255, 230, 150));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _py + _sl + 18, "Geladeira");

// Mensagem vazia
draw_set_font(_fnt_normal);
draw_set_color(make_color_rgb(200, 160, 100));
draw_text(_cx, _cy + _sl, "Nada aqui por enquanto.");

// Hint
draw_set_alpha(0.8 * anim_t);
draw_set_color(_fundo);
draw_rectangle(_px, _py + _ph + _sl - 28, _px + _pw, _py + _ph + _sl, false);
draw_set_color(_borda);
draw_roundrect(_px, _py + _ph + _sl - 28, _px + _pw, _py + _ph + _sl, _raio);
draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(200, 160, 80));
draw_text(_cx, _py + _ph + _sl - 14, "Esc  Fechar");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
