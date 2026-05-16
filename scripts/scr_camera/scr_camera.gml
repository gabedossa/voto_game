// =============================================================
//  scr_camera.gml
//  Câmera suave que segue o player em mapas grandes
// =============================================================

function camera_init() {
    cam_w      = 480;
    cam_h      = 270;
    cam_smooth = 0.12;
    cam_x      = 0;
    cam_y      = 0;

    cam_bound_x1 = 0;
    cam_bound_y1 = 0;
    cam_bound_x2 = room_width;
    cam_bound_y2 = room_height;

    cam_shake     = 0;
    cam_shake_max = 0;
    cam_shake_dur = 0;
    cam_shake_t   = 0;

    camera_set_view_size(view_camera[0], cam_w, cam_h);
    view_enabled    = true;
    view_visible[0] = true;

    if (instance_exists(obj_player)) {
        cam_x = obj_player.x;
        cam_y = obj_player.y;
    }
}

function camera_update() {
    // CORRIGIDO: garante que todas as variáveis existem antes de usar
    if (is_undefined(cam_x))          cam_x          = 0;
    if (is_undefined(cam_y))          cam_y          = 0;
    if (is_undefined(cam_w))          cam_w          = 480;
    if (is_undefined(cam_h))          cam_h          = 270;
    if (is_undefined(cam_smooth))     cam_smooth     = 0.12;
    if (is_undefined(cam_shake))      cam_shake      = 0;
    if (is_undefined(cam_shake_max))  cam_shake_max  = 0;
    if (is_undefined(cam_shake_dur))  cam_shake_dur  = 0;
    if (is_undefined(cam_shake_t))    cam_shake_t    = 0;
    if (is_undefined(cam_bound_x1))   cam_bound_x1   = 0;
    if (is_undefined(cam_bound_y1))   cam_bound_y1   = 0;
    if (is_undefined(cam_bound_x2))   cam_bound_x2   = room_width;
    if (is_undefined(cam_bound_y2))   cam_bound_y2   = room_height;

    cam_bound_x2 = room_width;
    cam_bound_y2 = room_height;

    var _tx = cam_x;
    var _ty = cam_y;

    if (instance_exists(obj_player)) {
        _tx = obj_player.x;
        _ty = obj_player.y;
    }

    cam_x = lerp(cam_x, _tx, cam_smooth);
    cam_y = lerp(cam_y, _ty, cam_smooth);

    var _sx = 0, _sy = 0;
    if (cam_shake > 0) {
        cam_shake_t++;
        var _prog = cam_shake_t / max(cam_shake_dur, 1);
        cam_shake = lerp(cam_shake_max, 0, _prog);
        _sx = random_range(-cam_shake, cam_shake);
        _sy = random_range(-cam_shake, cam_shake);
        if (_prog >= 1) cam_shake = 0;
    }

    var _vx = cam_x - cam_w / 2 + _sx;
    var _vy = cam_y - cam_h / 2 + _sy;
    _vx = clamp(_vx, cam_bound_x1, cam_bound_x2 - cam_w);
    _vy = clamp(_vy, cam_bound_y1, cam_bound_y2 - cam_h);

    if (cam_bound_x2 - cam_bound_x1 < cam_w) _vx = cam_bound_x1;
    if (cam_bound_y2 - cam_bound_y1 < cam_h) _vy = cam_bound_y1;

    camera_set_view_pos(view_camera[0], _vx, _vy);
}

function camera_shake(_intensity, _duration) {
    cam_shake_max = _intensity;
    cam_shake     = _intensity;
    cam_shake_dur = _duration;
    cam_shake_t   = 0;
}

function camera_snap() {
    if (is_undefined(cam_x)) cam_x = 0;
    if (is_undefined(cam_y)) cam_y = 0;
    if (instance_exists(obj_player)) {
        cam_x = obj_player.x;
        cam_y = obj_player.y;
    }
}

function camera_set_smooth(_val) {
    cam_smooth = clamp(_val, 0.01, 1.0);
}

function gui_to_world_x(_gx) {
    return _gx + camera_get_view_x(view_camera[0]);
}

function gui_to_world_y(_gy) {
    return _gy + camera_get_view_y(view_camera[0]);
}