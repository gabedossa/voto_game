// ── Sombra embaixo do personagem (não aparece no minigame) ──
if (room != asset_get_index("rm_room_minigame")) {
    var _shadow_w = sprite_get_width(sprite_index) * 0.3;   // largura da sombra
    var _shadow_h = _shadow_w * 0.15;                        // achatada (perspectiva)
    var _shadow_y = y + 14;                                  // nos pés (ajuste fino)

    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_ellipse(
        x - _shadow_w, _shadow_y - _shadow_h,
        x + _shadow_w, _shadow_y + _shadow_h,
        false
    );
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// ── Desenha o personagem por cima ──
draw_self();