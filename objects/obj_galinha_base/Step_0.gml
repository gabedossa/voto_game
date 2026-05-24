// ── Timer de pausa / movimento ──
if is_paused {
    pause_timer++;
    if pause_timer >= pause_interval {
        is_paused = false;
        pause_timer = 0;
        dir = choose(0, 90, 180, 270);
    }
} else {
    move_timer++;
    if move_timer >= move_interval {
        move_timer = 0;
        is_paused = true;
    }
}

// ── Movimento ──
var vx = 0, vy = 0;
if !is_paused {
    if dir == 0   { vx =  speed_walk; }
    if dir == 90  { vy = -speed_walk; }
    if dir == 180 { vx = -speed_walk; }
    if dir == 270 { vy =  speed_walk; }
}

// Salva posição antes de mover
var prev_x = x;
var prev_y = y;

x += vx;
y += vy;

// ── Colisão com parede ──
if place_meeting(x, y, obj_wall) {
    x = prev_x;
    y = prev_y;
    // Inverte direção
    dir = (dir + 180) mod 360;
    is_paused = true;
    pause_timer = 0;
}

// ── Animação das pernas ──
if !is_paused {
    leg_timer++;
    if leg_timer >= leg_speed {
        leg_timer = 0;
        leg_frame = (leg_frame + 1) mod 4;
    }
} else {
    leg_frame = 0; // pernas paradas
}