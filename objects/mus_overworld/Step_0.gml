if (!variable_global_exists("mus_overworld_handle")) {
    global.mus_overworld_handle = noone;
}

if (!audio_is_playing(global.mus_overworld_handle) && !audio_is_playing(snd_game_theme)) {
    global.mus_overworld_handle = audio_play_sound(snd_game_theme, 10, true);
}
