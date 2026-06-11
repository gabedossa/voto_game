if (keyboard_check_pressed(vk_escape) && !global.inventory_open) {
    if (!global.dialog_active) {
        is_open             = !is_open;
        global.game_paused  = is_open;
        obj_player.can_move = !is_open;
        selected_option     = 0;
        if (!is_open) anim_t = 0;
    }
}

if (!is_open) {
    anim_t = max(0, anim_t - 0.12);
    exit;
}

anim_t = min(1, anim_t + 0.12);

if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")))
    selected_option = (selected_option + 1) mod total_options;

if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")))
    selected_option = (selected_option - 1 + total_options) mod total_options;

if (keyboard_check_pressed(vk_enter)) {
    switch (selected_option) {
        case 0:
            is_open             = false;
            global.game_paused  = false;
            obj_player.can_move = true;
        break;
        case 1:
            //tirando a opção de salvar o jogo
        break;
        case 2:
            dialog_start("Sistema", [
                "Configura" + chr(231) + chr(245) + "es ainda em desenvolvimento.",
				"Em breve: volume, resolu" + chr(231) + chr(227) + "o e controles."
            ]);
            is_open             = false;
            global.game_paused  = false;
            obj_player.can_move = true;
        break;
        case 3:
            is_open             = false;
            global.game_paused  = false;
            obj_player.can_move = true;
            var _menu = asset_get_index("room_main_menu");
            if (_menu >= 0) room_goto(_menu);
        break;
        case 4:
            game_end();
        break;
    }
    show_debug_message("pause selected_option: " + string(selected_option) + " is_open: " + string(is_open));
}