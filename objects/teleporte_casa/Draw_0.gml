// Mostra dica "Z para entrar" quando player está perto
if (place_meeting(x, y, obj_player)) {
    var _fnt = asset_get_index("fnt_small");
    draw_set_font(_fnt);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(x, y - 20, "[Z] Entrar");
    draw_set_halign(fa_left);
}

// Visualização no editor
draw_set_alpha(0.3);
draw_set_color(c_yellow);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_set_alpha(1);