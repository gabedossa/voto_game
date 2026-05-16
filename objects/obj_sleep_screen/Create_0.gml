anim_t     = 0;
fade_out_t = 0;
phase      = "fade_in";
show_timer = 0;
saved_msg  = false;
 
// Avança o dia
global.day+=1;
global.hour       = 6;
global.minute     = 0;
global.time_timer = 0;
global.day_ended  = false;
global.energy     = global.energy_max;
global.tp_x       = 162;
global.tp_y       = 485;

// Salva só se o player existir
save_game();
saved_msg = true;
