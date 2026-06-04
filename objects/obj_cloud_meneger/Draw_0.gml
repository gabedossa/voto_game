// Só de dia
var _light = get_light_overlay();
if (_light.alpha > 0.05) exit;

draw_set_color(c_black);

// Desenha todas as sombras
for (var i = 0; i < array_length(clouds); i++) {
    var _c = clouds[i];
    for (var j = 0; j < array_length(_c.blobs); j++) {
        var _b = _c.blobs[j];
        draw_set_alpha(_c.max_alpha);
        draw_ellipse(
            _c.x + _b.ox - _b.rw, _c.y + _b.oy - _b.rh,
            _c.x + _b.ox + _b.rw, _c.y + _b.oy + _b.rh,
            false
        );
    }
}

draw_set_alpha(1);
draw_set_color(c_white);