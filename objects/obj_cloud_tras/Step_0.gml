for (var i = 0; i < array_length(clouds); i++) {
    clouds[i].x -= clouds[i].spd;
}

for (var i = array_length(clouds) - 1; i >= 0; i--) {
    var _c = clouds[i];
    var _w = sprite_get_width(_c.spr) * _c.scale;
    if (_c.x < -_w) {
        array_delete(clouds, i, 1);
    }
}

spawn_timer++;
if (spawn_timer >= spawn_delay && array_length(clouds) < max_clouds) {
    spawn_timer = 0;
    array_push(clouds, spawn_cloud(false));
}