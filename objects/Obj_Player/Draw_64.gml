// =============================================================
// DRAW GUI - obj_player
// =============================================================
if (stage_clear) {
    var _w  = display_get_gui_width();
    var _h  = display_get_gui_height();
    var _cx = _w * 0.5;
    var _cy = _h * 0.5;

    var _fnt = asset_get_index("fnt_normal");

    // Overlay escuro leve por trás
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _w, _h, false);
    draw_set_alpha(1);

    // ── Painel pergaminho ─────────────────────────────────────
    var _pw = 360;
    var _ph = 120;
    var _px = _cx - _pw / 2;
    var _py = _cy - _ph / 2;

    // sombra do painel
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_roundrect_ext(_px + 6, _py + 8, _px + _pw + 6, _py + _ph + 8, 16, 16, false);
    draw_set_alpha(1);

    // fundo pergaminho
    draw_set_color(make_color_rgb(238, 222, 186));
    draw_roundrect_ext(_px, _py, _px + _pw, _py + _ph, 16, 16, false);

    // bordas marrom/dourada
    draw_set_color(make_color_rgb(120, 85, 45));
    draw_roundrect_ext(_px, _py, _px + _pw, _py + _ph, 16, 16, true);
    draw_set_color(make_color_rgb(190, 150, 90));
    draw_roundrect_ext(_px + 4, _py + 4, _px + _pw - 4, _py + _ph - 4, 13, 13, true);

    // ── Texto ─────────────────────────────────────────────────
    draw_set_font(_fnt);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // sombra suave do texto
    draw_set_color(make_color_rgb(200, 175, 130));
    draw_text_transformed(_cx + 2, _cy + 2, "FASE CONCLU" + chr(205) + "DA", 1.6, 1.6, 0);

    // texto principal escuro
    draw_set_color(make_color_rgb(90, 60, 30));
    draw_text_transformed(_cx, _cy, "FASE CONCLU" + chr(205) + "DA", 1.6, 1.6, 0);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}