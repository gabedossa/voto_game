if (anim_t <= 0) exit;

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_normal");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_normal");

// ── Constantes de layout ──────────────────────────────────────
var _borda  = make_color_rgb(200, 150, 60);
var _fundo  = make_color_rgb(117, 66, 55);
var _raio   = 4;
var _pw     = 500;
var _ph     = 350;
var _px     = _cx - _pw / 2;
var _py     = _cy - _ph / 2;
var _sl     = (1 - anim_t) * 30;

// ── Overlay escuro ────────────────────────────────────────────
draw_set_alpha(0.5 * anim_t);
draw_set_color(c_black);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

// ── Fundo amadeirado ──────────────────────────────────────────
draw_set_alpha(0.95 * anim_t);
draw_set_color(_fundo);
draw_rectangle(_px, _py + _sl, _px + _pw, _py + _ph + _sl, false);

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
    draw_rectangle(_px + 4, _py + _sl + wy, _px + _pw - 4, _py + _sl + wy + 2, false);
}

// Nós de madeira
draw_set_alpha(0.12 * anim_t);
draw_set_color(make_color_rgb(80, 40, 10));
draw_ellipse(_px + 40, _py + _sl + 60, _px + 90, _py + _sl + 100, false);
draw_set_color(make_color_rgb(60, 30, 8));
draw_ellipse(_px + 52, _py + _sl + 70, _px + 78, _py + _sl + 90, false);
draw_set_color(make_color_rgb(40, 20, 5));
draw_ellipse(_px + 60, _py + _sl + 76, _px + 70, _py + _sl + 84, false);

draw_set_color(make_color_rgb(80, 40, 10));
draw_ellipse(_px + _pw - 90, _py + _sl + _ph - 100, _px + _pw - 40, _py + _sl + _ph - 60, false);
draw_set_color(make_color_rgb(60, 30, 8));
draw_ellipse(_px + _pw - 78, _py + _sl + _ph - 90, _px + _pw - 52, _py + _sl + _ph - 70, false);
draw_set_color(make_color_rgb(40, 20, 5));
draw_ellipse(_px + _pw - 70, _py + _sl + _ph - 84, _px + _pw - 60, _py + _sl + _ph - 76, false);

draw_set_color(make_color_rgb(80, 40, 10));
draw_ellipse(_px + _pw - 70, _py + _sl + 140, _px + _pw - 30, _py + _sl + 180, false);
draw_set_color(make_color_rgb(60, 30, 8));
draw_ellipse(_px + _pw - 60, _py + _sl + 150, _px + _pw - 40, _py + _sl + 170, false);
draw_set_color(make_color_rgb(40, 20, 5));
draw_ellipse(_px + _pw - 55, _py + _sl + 156, _px + _pw - 45, _py + _sl + 164, false);

// Borda dourada
draw_set_alpha(0.9 * anim_t);
draw_set_color(_borda);
draw_roundrect(_px, _py + _sl, _px + _pw, _py + _ph + _sl, _raio);
draw_set_alpha(1);

// ── Título ────────────────────────────────────────────────────
draw_set_alpha(anim_t);
draw_set_color(_fundo);
draw_rectangle(_px, _py + _sl, _px + _pw, _py + _sl + 36, false);
draw_set_color(_borda);
draw_roundrect(_px, _py + _sl, _px + _pw, _py + _sl + 36, _raio);
draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(255, 230, 150));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _py + _sl + 18, "Inventario");
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// ── Abas de categoria ─────────────────────────────────────────
var _tab_w  = _pw / array_length(categories);
var _tab_y1 = _py + _sl + 40;
var _tab_y2 = _tab_y1 + 28;

for (var i = 0; i < array_length(categories); i++) {
    var _tx  = _px + i * _tab_w;
    var _sel = (i == selected_cat);

    var _tab_alpha;
    var _tab_color;

    if (_sel) {
        _tab_alpha = 0.95;
        _tab_color = make_color_rgb(150, 90, 40);
    } else {
        _tab_alpha = 0.5;
        _tab_color = _fundo;
    }

    draw_set_alpha(_tab_alpha * anim_t);
    draw_set_color(_tab_color);
    draw_rectangle(_tx + 2, _tab_y1, _tx + _tab_w - 2, _tab_y2, false);
    draw_set_color(_borda);
    draw_roundrect(_tx + 2, _tab_y1, _tx + _tab_w - 2, _tab_y2, _raio);
    draw_set_alpha(1);

    draw_set_font(_fnt_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(anim_t);
    if (_sel) {
        draw_set_color(make_color_rgb(255, 230, 150));
    } else {
        draw_set_color(make_color_rgb(200, 160, 100));
    }
    draw_text(_tx + _tab_w / 2, (_tab_y1 + _tab_y2) / 2, categories[i]);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// ── Lista de itens ────────────────────────────────────────────
var _itens_cat = [];
for (var i = 0; i < array_length(global.inventory); i++) {
    if (string_pos(categories[selected_cat], global.inventory[i]) > 0) {
        array_push(_itens_cat, global.inventory[i]);
    }
}

var _list_y = _tab_y2 + 8;
var _item_h = 36;

if (array_length(_itens_cat) == 0) {
    draw_set_font(_fnt_normal);
    draw_set_color(make_color_rgb(200, 160, 100));
    draw_set_alpha(anim_t);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_cx, _list_y + 60, "Nenhum item.");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
} else {
    for (var i = 0; i < array_length(_itens_cat); i++) {
        var _iy     = _list_y + i * _item_h;
        var _active = (selected_option == i);

        var _item_alpha;
        var _item_color;

        if (_active) {
            _item_alpha = 0.95;
            _item_color = make_color_rgb(150, 90, 40);
        } else {
            _item_alpha = 0.5;
            _item_color = _fundo;
        }

        draw_set_alpha(_item_alpha * anim_t);
        draw_set_color(_item_color);
        draw_rectangle(_px + 12, _iy, _px + _pw - 12, _iy + _item_h - 4, false);
        draw_set_color(_borda);
        draw_roundrect(_px + 12, _iy, _px + _pw - 12, _iy + _item_h - 4, _raio);
        draw_set_alpha(1);

        draw_set_font(_fnt_bold);
        draw_set_alpha(anim_t);
        draw_set_valign(fa_middle);
        if (_active) {
            draw_set_color(make_color_rgb(255, 240, 180));
        } else {
            draw_set_color(make_color_rgb(210, 170, 100));
        }
        draw_text(_px + 24, _iy + (_item_h - 4) / 2, _itens_cat[i]);
        draw_set_valign(fa_top);
        draw_set_alpha(1);
    }
}

// ── Hint ──────────────────────────────────────────────────────
draw_set_alpha(0.8 * anim_t);
draw_set_color(_fundo);
draw_rectangle(_px, _py + _ph + _sl - 28, _px + _pw, _py + _ph + _sl, false);
draw_set_color(_borda);
draw_roundrect(_px, _py + _ph + _sl - 28, _px + _pw, _py + _ph + _sl, _raio);
draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(200, 160, 80));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, _py + _ph + _sl - 14, "A/D  Categoria    Esc/E  Fechar");
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
