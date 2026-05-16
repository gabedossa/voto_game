musica_atual = noone;

if (!audio_is_playing(snd_game_theme)) {
    musica_atual = audio_play_sound(snd_game_theme, 10, true);
}