// ══════════════════════════════════════════════════════════
// COLISOR DE RESET — mata a Luisa e reinicia o minigame
// Usado em buracos, espinhos, lava ou zonas de game over
// ══════════════════════════════════════════════════════════
if (place_meeting(x, y, obj_reset_minigame)) {
    
    // Zera o progresso da tentativa atual
    // As moedas coletadas até aqui são perdidas, como em plataformers clássicos
    moedas = 0;
    
    // Reseta velocidades para evitar que a Luisa "continue caindo" no respawn
    spd_x = 0;
    spd_y = 0;
    
    // Garante que o player volte ao spawn da sala
    // (a posição inicial será aplicada pelo Room Start ou pelo Create do player)
    global.tp_x = 95;   // mesmo X usado quando entra no minigame
    global.tp_y = 576;  // mesmo Y usado quando entra no minigame
    
    // Reinicia a sala do minigame
    // room_restart() também funcionaria, mas room_goto garante que o
    // Room Start dispare e o estado seja recriado do zero
    room_goto(rm_room_minigame);
    
    // Sai do Step imediatamente para evitar processar movimento/colisão
    // depois de já ter pedido troca de sala
    exit;
}