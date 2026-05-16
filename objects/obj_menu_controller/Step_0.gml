// =============================================================
//  obj_menu_controller — Step Event
// =============================================================

save_exists = file_exists("save.json");

if (!anim_ready) {
    anim_t += 0.025;

    if (anim_t >= 1) {
        anim_t = 1;
        anim_ready = true;
    }
}

for (var i = 0; i < array_length(particles); i++) {
    particles[i].y -= particles[i].spd;

    if (particles[i].y < -10) {
        particles[i].y = room_height + 10;
        particles[i].x = random(room_width);
    }
}

switch (menu_state) {
    case "main":
        if (selected_option < 0) {
            selected_option = 0;
        }

        if (selected_option > 2) {
            selected_option = 2;
        }

        if (!save_exists && selected_option == 1) {
            selected_option = 0;
        }

        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            selected_option = (selected_option + 1) mod 3;

            if (!save_exists && selected_option == 1) {
                selected_option = 2;
            }
        }

        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            selected_option = (selected_option - 1 + 3) mod 3;

            if (!save_exists && selected_option == 1) {
                selected_option = 0;
            }
        }

        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            switch (selected_option) {
                case 0:
                    if (save_exists) {
                        menu_state = "confirm_new";
                        selected_option = 1;
                    } else {
                        start_new_game();
                    }
                break;

                case 1:
                    if (save_exists) {
                        start_load_game();
                    }
                break;

                case 2:
                    game_end();
                break;
            }
        }
    break;

    case "confirm_new":
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
            selected_option = 1 - selected_option;
        }

        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            if (selected_option == 0) {
                start_new_game();
            } else {
                menu_state = "main";
                selected_option = 0;
            }
        }

        if (keyboard_check_pressed(vk_escape)) {
            menu_state = "main";
            selected_option = 0;
        }
    break;
}

function start_new_game() {
    if (file_exists("save.json")) {
        file_delete("save.json");
    }

    global.day = 1;
    global.hour = 6;
    global.minute = 0;
    global.money = 500;

    if (!variable_global_exists("energy_max")) {
        global.energy_max = 100;
    }

    global.energy = global.energy_max;
    global.inventory = [];
    global.flags = {};

    room_goto(rm_overworld);
}

function start_load_game() {
    if (load_game()) {
        room_goto(rm_overworld);
    }
}
