for (var i = 0; i < array_length(clouds); i++) {
    var _c = clouds[i];
    draw_sprite_ext(
        _c.spr, 0,
        _c.x, _c.y,
        _c.scale, _c.scale,
        0,
        c_white, _c.alpha
    );
}