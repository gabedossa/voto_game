clouds = [];
max_clouds = 6;
spawn_timer = 0;
spawn_delay = 120;

cloud_sprites = [spr_cloud];
depth = -10000;   // traz pra frente de tudo (só teste)

spawn_cloud = function(_inside) {
    var _spr   = cloud_sprites[irandom(array_length(cloud_sprites) - 1)];
    var _spd   = 0.2 + random(0.6);
    var _scale = 0.6 + random(0.8);
    var _alpha = 0.5 + random(0.5);
    var _cy = random(room_height);

    var _cx;
    if (_inside) {
        _cx = random(room_width);
    } else {
        _cx = room_width + sprite_get_width(_spr) * _scale;
    }

    return {
        x: _cx, y: _cy, spr: _spr,
        spd: _spd, scale: _scale, alpha: _alpha
    };
};

for (var i = 0; i < max_clouds; i++) {
    array_push(clouds, spawn_cloud(true));
}

show_debug_message("CLOUDS: " + string(array_length(clouds)) + " | sprite existe: " + string(sprite_exists(spr_cloud)));