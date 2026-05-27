// Movimento
speed_walk = .8;
dir = choose(0, 90, 180, 270); // direção inicial aleatória
facing_x = choose(1, -1);
move_timer = 0;
move_interval = 12; // frames até mudar direção (~0.2s a 60fps)
is_paused = false;
pause_timer = 0;
pause_interval = 12;

// Animação das pernas (South Park style)
leg_frame = 0;
leg_timer = 0;
leg_speed = 3; // frames por frame de animação

// Visual — tamanho base
body_w = 16;
body_h = 14;
leg_h = 6;

// Cor da galinha (override nos filhos)
body_color = c_white;
beak_color = make_color_rgb(255, 200, 50);
comb_color = c_red;