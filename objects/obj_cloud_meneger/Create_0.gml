clouds = [];               // lista de sombras ativas
max_clouds = 3;            // quantas sombras simultâneas
spawn_timer = 0;
spawn_delay = 90;          // frames entre tentativas de spawn

// Função que cria uma nova sombra de nuvem
spawn_cloud = function() {
    var _base_w = 80 + random(100);
    var _base_h = _base_w * (0.5 + random(0.3));
    var _spd    = 0.3 + random(0.5);
    var _dir    = 200 + random(40);   // diagonal suave

    // Nasce numa borda aleatória, fora da tela
    var _margin = _base_w * 2;
    var _sx, _sy;
    if (random(1) < 0.5) {
        // entra pela esquerda/cima
        _sx = random(room_width);
        _sy = -_margin;
    } else {
        _sx = -_margin;
        _sy = random(room_height);
    }

    // gera blobs internos pro formato orgânico
    var _blobs = [];
    var _bc = 4 + irandom(3);
    for (var i = 0; i < _bc; i++) {
        array_push(_blobs, {
            ox: random_range(-_base_w * 0.4, _base_w * 0.4),
            oy: random_range(-_base_h * 0.4, _base_h * 0.4),
            rw: _base_w * (0.4 + random(0.4)),
            rh: _base_h * (0.4 + random(0.4))
        });
    }

    return {
        x: _sx,
        y: _sy,
        vx: lengthdir_x(_spd, _dir),
        vy: lengthdir_y(_spd, _dir),
        w: _base_w,
        h: _base_h,
        margin: _margin,
        max_alpha: 0.10 + random(0.06),
        blobs: _blobs
    };
};

// Já começa com algumas sombras espalhadas pelo mapa
for (var i = 0; i < max_clouds; i++) {
    var _c = spawn_cloud();
    _c.x = random(room_width);    // posição inicial dentro do mapa
    _c.y = random(room_height);
    array_push(clouds, _c);
}