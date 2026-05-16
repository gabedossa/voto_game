// =============================================================
//  obj_minigame_unboxing — Create Event
//  Minigame de abrir a caixa de equipamentos
// =============================================================
fase           = 0;
// 0 = clicar nas 4 fitinhas
// 1 = clicar nas 2 fitas grandes
// 2 = abrir a caixa
// 3 = estourar o papel bolha
// 4 = coletar itens e sair

fitas_pequenas  = 4;
fitas_grandes   = 2;
bolha_cliques   = 10;
caixa_aberta    = false;

// Posição da caixa no centro da tela
cx = room_width  / 2;
cy = room_height / 2;

// Mensagem de instrução
instrucao = "Clique nas fitinhas para abrir a caixa!";
