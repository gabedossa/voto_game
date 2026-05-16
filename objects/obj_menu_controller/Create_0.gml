// =============================================================
//  obj_menu_controller — Create Event
//  Menu inicial: Novo Jogo, Carregar, Idiomas, Sair
//  Coloque este objeto na room_main_menu
// =============================================================

// Estado do menu
menu_state      = "main";   // "main", "language", "confirm_new", "confirm_quit"
selected_option = 0;
total_options   = 4;        // Novo Jogo, Carregar, Idiomas, Sair

// Animação de entrada
anim_t     = 0;
anim_ready = false;

// Verifica se existe save para habilitar "Carregar"
save_exists = file_exists("save.json");

// Partículas decorativas
particles = [];
for (var i = 0; i < 30; i++) {
    array_push(particles, {
        x:     random(room_width),
        y:     random(room_height),
        spd:   random_range(0.3, 1.2),
        alpha: random_range(0.1, 0.6),
        size:  random_range(2, 5)
    });
}

