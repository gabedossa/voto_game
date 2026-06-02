var _light = get_light_overlay();
var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Camada 1: escurecimento (normal)
if (_light.alpha > 0) {
    draw_set_alpha(_light.alpha);
    draw_set_color(_light.color);
    draw_rectangle(0, 0, _w, _h, false);
}

// Camada 2: tint colorido (aditivo — ilumina e satura sem escurecer)
if (_light.tint_amt > 0) {
    gpu_set_blendmode(bm_add);
    draw_set_alpha(_light.tint_amt);
    draw_set_color(_light.tint);
    draw_rectangle(0, 0, _w, _h, false);
    gpu_set_blendmode(bm_normal);
}

draw_set_alpha(1);
draw_set_color(c_white);