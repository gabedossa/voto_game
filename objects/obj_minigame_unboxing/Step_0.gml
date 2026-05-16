// =============================================================
//  obj_minigame_unboxing — Step Event
// =============================================================
if (mouse_check_button_pressed(mb_left)) {
    switch (fase) {
        case 0: // fitinhas pequenas
            fitas_pequenas--;
            if (fitas_pequenas <= 0) {
                fase      = 1;
                instrucao = "Agora clique nas fitas grandes!";
            }
        break;

        case 1: // fitas grandes
            fitas_grandes--;
            if (fitas_grandes <= 0) {
                fase      = 2;
                instrucao = "Abra a caixa!";
            }
        break;

        case 2: // abre a caixa
            caixa_aberta = true;
            fase         = 3;
            instrucao    = "Tem algo dentro... clique no papel bolha!";
        break;

        case 3: // papel bolha
            bolha_cliques--;
            if (bolha_cliques <= 0) {
                fase      = 4;
                instrucao = "Clique nos itens para pegar!";
            }
        break;

        case 4: // coleta os itens e sai
            give_item("Camera");
            give_item("Microfone");
            flag_set("missao1_equipamentos", true);
            room_goto(room_house_luisa);
        break;
    }
}
