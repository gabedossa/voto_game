// Só acende quando há escuridão (noite/transições)
var _light = get_light_overlay();
if (_light.alpha <= 0.05) exit; // dia: não desenha nada

// Intensidade do brilho acompanha a escuridão
var _intensity = clamp(_light.alpha, 0, 1);

// Converte posição do mundo -> coordenadas de GUI
var _cam   = view_camera[0];
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);
var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _sx = (x - _cam_x) / _cam_w * _gui_w;
var _sy = (y - _cam_y) / _cam_h * _gui_h;
var _r  = glow_radius / _cam_w * _gui_w;

// Desenho aditivo (luz soma, não cobre)
gpu_set_blendmode(bm_add);

var _layers = 12;                  // mais camadas = degradê mais suave
for (var i = _layers; i >= 1; i--) {
    var _f = i / _layers;
    var _a = (1 - _f) * 0.12 * _intensity;   // alpha menor por camada
    draw_set_alpha(_a);
    draw_set_color(glow_color);
    draw_circle(_sx, _sy, _r * _f, false);
}

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);