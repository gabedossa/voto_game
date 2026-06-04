// Move cada sombra
for (var i = 0; i < array_length(clouds); i++) {
    var _c = clouds[i];
    _c.x += _c.vx;
    _c.y += _c.vy;
}

// Remove sombras que saíram totalmente do mapa
for (var i = array_length(clouds) - 1; i >= 0; i--) {
    var _c = clouds[i];
    if (_c.x < -_c.margin || _c.x > room_width  + _c.margin ||
        _c.y < -_c.margin || _c.y > room_height + _c.margin) {
        array_delete(clouds, i, 1);
    }
}

// Repõe sombras pra manter o total
spawn_timer++;
if (spawn_timer >= spawn_delay && array_length(clouds) < max_clouds) {
    spawn_timer = 0;
    array_push(clouds, spawn_cloud());
}