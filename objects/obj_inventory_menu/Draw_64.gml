if (anim_t <= 0) exit;

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_normal");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_normal");

// ── Paleta (mesma do menu de pause) ───────────────────────────
var _bg      = make_color_rgb(238, 222, 186);  // pergaminho
var _bg_sel  = make_color_rgb(210, 160, 70);   // selecionado
var _bg_slot = make_color_rgb(220, 202, 165);  // slot normal
var _borda_e = make_color_rgb(120, 85, 45);    // borda externa marrom
var _borda_i = make_color_rgb(190, 150, 90);   // borda interna dourada
var _txt_esc = make_color_rgb(95, 65, 35);     // texto escuro
var _txt_dim = make_color_rgb(120, 90, 55);    // texto apagado

// ── Overlay escuro de fundo ───────────────────────────────────
draw_set_alpha(0.6 * anim_t);
draw_set_color(c_black);
draw_rectangle(0, 0, _W, _H, false);
draw_set_alpha(1);

var _pw      = 460;
var _ph      = 380;
var _px      = _cx - _pw / 2;
var _py      = _cy - _ph / 2;
var _slide_y = (1 - anim_t) * 30;
var _top     = _py + _slide_y;

// ── Sombra do painel ──────────────────────────────────────────
draw_set_alpha(0.3 * anim_t);
draw_set_color(c_black);
draw_roundrect_ext(_px + 6, _top + 8, _px + _pw + 6, _top + _ph + 8, 16, 16, false);
draw_set_alpha(1);

// ── Fundo pergaminho liso (OPACO) ─────────────────────────────
draw_set_alpha(1);
draw_set_color(_bg);
draw_roundrect_ext(_px, _top, _px + _pw, _top + _ph, 16, 16, false);

// ── Bordas ────────────────────────────────────────────────────
draw_set_color(_borda_e);
draw_roundrect_ext(_px, _top, _px + _pw, _top + _ph, 16, 16, true);
draw_set_color(_borda_i);
draw_roundrect_ext(_px + 4, _top + 4, _px + _pw - 4, _top + _ph - 4, 13, 13, true);

// ── Título ────────────────────────────────────────────────────
draw_set_halign(fa_center);

draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(200, 175, 130));
draw_text_transformed(_cx + 1, _top + 29, "Invent" + chr(225) + "rio", 1.3, 1.3, 0);
draw_set_color(make_color_rgb(90, 60, 30));
draw_text_transformed(_cx, _top + 28, "Invent" + chr(225) + "rio", 1.3, 1.3, 0);

draw_set_color(make_color_rgb(150, 115, 70));
draw_line(_px + 40, _top + 56, _px + _pw - 40, _top + 56);

draw_set_halign(fa_left);

// ── Abas de categoria ─────────────────────────────────────────
var _tab_y  = _top + 66;
var _tab_h  = 28;
var _tab_w  = (_pw - 40) / array_length(categories);

for (var i = 0; i < array_length(categories); i++) {
    var _tx  = _px + 20 + i * _tab_w;
    var _sel = (i == selected_cat);

    if (_sel) {
        draw_set_color(_bg_sel);
        draw_roundrect_ext(_tx, _tab_y, _tx + _tab_w - 6, _tab_y + _tab_h, 6, 6, false);
        draw_set_color(_borda_i);
        draw_roundrect_ext(_tx, _tab_y, _tx + _tab_w - 6, _tab_y + _tab_h, 6, 6, true);
    } else {
        draw_set_color(_bg_slot);
        draw_roundrect_ext(_tx, _tab_y, _tx + _tab_w - 6, _tab_y + _tab_h, 6, 6, false);
    }

    draw_set_font(_fnt_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    if (_sel) {
        draw_set_color(make_color_rgb(255, 250, 230));
    } else {
        draw_set_color(_txt_dim);
    }
    draw_text((_tx + _tx + _tab_w - 6) / 2, _tab_y + _tab_h / 2, categories[i]);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// ── Filtra itens da categoria ─────────────────────────────────
var _itens_cat = [];
for (var i = 0; i < array_length(global.inventory); i++) {
    if (string_pos(categories[selected_cat], global.inventory[i]) > 0) {
        array_push(_itens_cat, global.inventory[i]);
    }
}

// ── Grade de slots ────────────────────────────────────────────
var _grid_x   = _px + 20;
var _grid_y   = _tab_y + _tab_h + 14;
var _cols     = 5;
var _slot     = 70;
var _slot_gap = 8;
var _foot_h   = 32;

if (array_length(_itens_cat) == 0) {
    draw_set_font(_fnt_normal);
    draw_set_color(_txt_dim);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_cx, _grid_y + 60, "Nenhum item nesta categoria.");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
} else {
    for (var i = 0; i < array_length(_itens_cat); i++) {
        var _col = i mod _cols;
        var _row = i div _cols;
        var _sx  = _grid_x + _col * (_slot + _slot_gap);
        var _sy  = _grid_y + _row * (_slot + _slot_gap);
        var _active = (selected_option == i);

        // fundo do slot
        if (_active) {
            draw_set_color(_bg_sel);
            draw_roundrect_ext(_sx, _sy, _sx + _slot, _sy + _slot, 8, 8, false);
            draw_set_color(_borda_i);
            draw_roundrect_ext(_sx, _sy, _sx + _slot, _sy + _slot, 8, 8, true);
        } else {
            draw_set_color(_bg_slot);
            draw_roundrect_ext(_sx, _sy, _sx + _slot, _sy + _slot, 8, 8, false);
            draw_set_color(make_color_rgb(170, 140, 95));
            draw_roundrect_ext(_sx, _sy, _sx + _slot, _sy + _slot, 8, 8, true);
        }

        // ícone do item (sprite se existir, senão inicial)
        var _item_name = _itens_cat[i];
        var _spr = asset_get_index("spr_item_" + _item_name);

        if (_spr >= 0 && sprite_exists(_spr)) {
            draw_sprite_ext(_spr, 0, _sx + _slot / 2, _sy + _slot / 2 - 6, 1, 1, 0, c_white, 1);
        } else {
            draw_set_font(_fnt_bold);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_color(_txt_esc);
            draw_text_transformed(_sx + _slot / 2, _sy + _slot / 2 - 6,
                string_upper(string_copy(_item_name, 1, 1)), 2, 2, 0);
        }

        // nome curto embaixo
        draw_set_font(_fnt_small);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        if (_active) {
            draw_set_color(make_color_rgb(90, 60, 30));
        } else {
            draw_set_color(_txt_dim);
        }
        var _short = _item_name;
        if (string_length(_short) > 8) {
            _short = string_copy(_short, 1, 7) + ".";
        }
        draw_text(_sx + _slot / 2, _sy + _slot - 4, _short);
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// ── Hint ──────────────────────────────────────────────────────
draw_set_halign(fa_center);
draw_set_font(_fnt_small);
draw_set_color(make_color_rgb(130, 100, 60));
draw_text_transformed(_cx, _top + _ph - 18,
    "A/D  Categoria    Setas  Navegar    Esc/E  Fechar", 1, 1, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);