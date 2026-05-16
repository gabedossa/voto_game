// =============================================================
// ALARM 0 - obj_game_manager
// =============================================================

if (variable_global_exists("day_ended") && global.day_ended) {
    end_day();
}