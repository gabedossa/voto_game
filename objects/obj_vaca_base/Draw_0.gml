// Desenha a vaca virada para o lado em que ela esta andando.

var _xscale = abs(image_xscale) * facing_x;
var _yscale = image_yscale;
var _draw_x = x;

if (facing_x < 0) {
    _draw_x = x + sprite_width * abs(image_xscale);
}

draw_sprite_ext(
    sprite_index,
    image_index,
    _draw_x,
    y,
    _xscale,
    _yscale,
    image_angle,
    image_blend,
    image_alpha
);