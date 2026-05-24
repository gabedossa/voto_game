// Desenha o sprite real da galinha.
// Enquanto anda, o sprite sobe e desce como um pulinho.

var _xscale = abs(image_xscale);
var _yscale = image_yscale;
var _draw_x = x;
var _draw_y = y;

if (!is_paused) {
    _draw_y += -abs(sin(current_time * 0.02)) * 4;
}

if (dir == 180) {
    _xscale = -_xscale;
    _draw_x = x + sprite_width * abs(image_xscale);
}

draw_sprite_ext(
    sprite_index,
    image_index,
    _draw_x,
    _draw_y,
    _xscale,
    _yscale,
    image_angle,
    image_blend,
    image_alpha
);