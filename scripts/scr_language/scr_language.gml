// =============================================================
//  scr_language.gml
//  Sistema de idiomas — PT-BR e EN-US
//  Chame language_init() no Create Event do obj_game_manager
// =============================================================

function language_init() {
    global.language = "pt";

    global.lang_pt = {};
    global.lang_pt[$ "menu_new_game"]    = "Novo Jogo";
    global.lang_pt[$ "menu_load"]        = "Carregar";
    global.lang_pt[$ "menu_languages"]   = "Idiomas";
    global.lang_pt[$ "menu_quit"]        = "Sair";
    global.lang_pt[$ "menu_subtitle"]    = "Uma historia sobre o campo brasileiro";
    global.lang_pt[$ "pause_title"]      = "Pausado";
    global.lang_pt[$ "pause_resume"]     = "Continuar";
    global.lang_pt[$ "pause_save"]       = "Salvar Jogo";
    global.lang_pt[$ "pause_settings"]   = "Configuracoes";
    global.lang_pt[$ "pause_main_menu"]  = "Menu Principal";
    global.lang_pt[$ "pause_quit"]       = "Sair do Jogo";
    global.lang_pt[$ "lang_title"]       = "Selecionar Idioma";
    global.lang_pt[$ "lang_pt"]          = "Portugues (Brasil)";
    global.lang_pt[$ "lang_en"]          = "English";
    global.lang_pt[$ "lang_back"]        = "Voltar";
    global.lang_pt[$ "sleep_title"]      = "Boa noite...";
    global.lang_pt[$ "sleep_day"]        = "Dia";
    global.lang_pt[$ "sleep_saved"]      = "Jogo salvo automaticamente.";
    global.lang_pt[$ "sleep_continue"]   = "Pressione Espaco para continuar";
    global.lang_pt[$ "save_success"]     = "Jogo salvo!";
    global.lang_pt[$ "save_error"]       = "Erro ao salvar!";
    global.lang_pt[$ "save_auto"]        = "Salvo automaticamente.";
    global.lang_pt[$ "hud_day"]          = "Dia";
    global.lang_pt[$ "hud_energy"]       = "Energia";
    global.lang_pt[$ "hud_money"]        = "$";
    global.lang_pt[$ "confirm_new_game"] = "Tem certeza? O progresso nao salvo sera perdido.";
    global.lang_pt[$ "confirm_quit"]     = "Deseja sair do jogo?";
    global.lang_pt[$ "confirm_yes"]      = "Sim";
    global.lang_pt[$ "confirm_no"]       = "Nao";
    global.lang_pt[$ "item_cartazes"]    = "Cartazes";
    global.lang_pt[$ "item_camera"]      = "Camera";
    global.lang_pt[$ "item_microfone"]   = "Microfone";
    global.lang_pt[$ "item_ticket"]      = "Ticket Especial";
    global.lang_pt[$ "item_received"]    = "Item recebido:";

    global.lang_en = {};
    global.lang_en[$ "menu_new_game"]    = "New Game";
    global.lang_en[$ "menu_load"]        = "Load Game";
    global.lang_en[$ "menu_languages"]   = "Languages";
    global.lang_en[$ "menu_quit"]        = "Quit";
    global.lang_en[$ "menu_subtitle"]    = "A story about the Brazilian countryside";
    global.lang_en[$ "pause_title"]      = "Paused";
    global.lang_en[$ "pause_resume"]     = "Resume";
    global.lang_en[$ "pause_save"]       = "Save Game";
    global.lang_en[$ "pause_settings"]   = "Settings";
    global.lang_en[$ "pause_main_menu"]  = "Main Menu";
    global.lang_en[$ "pause_quit"]       = "Quit Game";
    global.lang_en[$ "lang_title"]       = "Select Language";
    global.lang_en[$ "lang_pt"]          = "Portugues (Brasil)";
    global.lang_en[$ "lang_en"]          = "English";
    global.lang_en[$ "lang_back"]        = "Back";
    global.lang_en[$ "sleep_title"]      = "Good night...";
    global.lang_en[$ "sleep_day"]        = "Day";
    global.lang_en[$ "sleep_saved"]      = "Game saved automatically.";
    global.lang_en[$ "sleep_continue"]   = "Press Space to continue";
    global.lang_en[$ "save_success"]     = "Game saved!";
    global.lang_en[$ "save_error"]       = "Save error!";
    global.lang_en[$ "save_auto"]        = "Auto-saved.";
    global.lang_en[$ "hud_day"]          = "Day";
    global.lang_en[$ "hud_energy"]       = "Energy";
    global.lang_en[$ "hud_money"]        = "$";
    global.lang_en[$ "confirm_new_game"] = "Are you sure? Unsaved progress will be lost.";
    global.lang_en[$ "confirm_quit"]     = "Quit the game?";
    global.lang_en[$ "confirm_yes"]      = "Yes";
    global.lang_en[$ "confirm_no"]       = "No";
    global.lang_en[$ "item_cartazes"]    = "Posters";
    global.lang_en[$ "item_camera"]      = "Camera";
    global.lang_en[$ "item_microfone"]   = "Microphone";
    global.lang_en[$ "item_ticket"]      = "Special Ticket";
    global.lang_en[$ "item_received"]    = "Item received:";
}

// ── CORRIGIDO: removido operador ternário ? : ─────────────────
function loc(_key) {
    var _table;
    if (global.language == "en") {
        _table = global.lang_en;
    } else {
        _table = global.lang_pt;
    }
    var _val = _table[$ _key];
    if (is_undefined(_val)) return "[" + _key + "]";
    return _val;
}

function set_language(_lang) {
    global.language = _lang;
    var _prefs = load_prefs();
    _prefs[$ "language"] = _lang;
    save_prefs(_prefs);
}

function save_prefs(_struct) {
    var _map  = ds_map_create();
    var _keys = variable_struct_get_names(_struct);
    for (var i = 0; i < array_length(_keys); i++) {
        ds_map_add(_map, _keys[i], _struct[$ _keys[i]]);
    }
    var _file = file_text_open_write("prefs.json");
    file_text_write_string(_file, json_encode(_map));
    file_text_close(_file);
    ds_map_destroy(_map);
}

function load_prefs() {
    var _struct = {};
    if (!file_exists("prefs.json")) return _struct;
    var _file = file_text_open_read("prefs.json");
    var _json = file_text_read_string(_file);
    file_text_close(_file);
    var _map  = json_decode(_json);
    var _keys = ds_map_keys_to_array(_map);
    for (var i = 0; i < array_length(_keys); i++) {
        _struct[$ _keys[i]] = _map[? _keys[i]];
    }
    ds_map_destroy(_map);
    return _struct;
}