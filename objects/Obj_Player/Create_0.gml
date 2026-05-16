// =============================================================
// CREATE - obj_player
// =============================================================

persistent = false;

// Movimento top down
move_speed = .9;
hsp = move_speed;
running    = move_speed * 2;

facing = 0;

// Plataforma
spd_x = 0;
spd_y = 0;

gravidade      = 0.5;
forca_pulo     = -10;
vel_plataforma = move_speed*2;

// Controle
can_move = true;

// Energia corrida
run_energy_timer = 0;

// Minigame
stage_clear = false;
stage_timer = 0;
moedas = 0;
