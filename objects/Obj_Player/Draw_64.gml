// =============================================================
// DRAW GUI - obj_player
// =============================================================

if (stage_clear) {

    var _w = display_get_gui_width();
    var _h = display_get_gui_height();

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // sombra
    draw_set_color(c_black);

    draw_text(
        _w * 0.5 + 4,
        _h * 0.5 + 4,
        "STAGE CLEARED"
    );

    // texto principal
    draw_set_color(c_yellow);

    draw_text(
        _w * 0.5,
        _h * 0.5,
        "STAGE CLEARED"
    );

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}