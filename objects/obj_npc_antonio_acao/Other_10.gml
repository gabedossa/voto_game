// obj_npc_antonio_acao - User Event 0
// Controla a conversa do Sr. Antonio e libera o minigame no dia 2.

if (global.dialog_active) {
    exit;
}

if (global.day == 1 && !talked_today) {

    talked_today = true;

    dialog_start("Sr. Antonio", [
        "Ola, Luisa.",
        "Bom te ver por aqui.",
        "A vida no campo nao e facil, mas tem muito valor.",
        "Tem gente na cidade que ainda olha para o produtor rural com preconceito.",
        "Mas sem o campo, nao existe comida na mesa."
    ]);

    exit;
}

if (global.day == 1 && talked_today) {

    dialog_start("Sr. Antonio", [
        "Oi Luisa, hoje temos tomates fresquinhos.",
        "Fique a vontade para olhar.",
        "Nao usamos agrotoxicos nos tomates.",
        "Usamos joaninhas para comer os pulgoes",
        "que tentam atacar as plantacoes."
    ]);

    exit;
}

if (global.day == 2 && !flag_get("missao1_programa")) {

    flag_set("missao1_programa", true);
    talked_today = true;

    dialog_start("Sr. Antonio", [
        "Bom dia, Luisa, como vai?",
        "Hoje infelizmente nao tenho nada para vender.",
        "As estradas estao cheias de buracos e problemas.",
        "O transporte das mercadorias ficou quase impossivel.",
        "Meus produtos se perderam pela estrada novamente.",
        "Me ajude a recuperar meus produtos, por favor!"
    ]);

    flag_set("iniciar_minigame", true);
    alarm[0] = -1;

    exit;
}

if (
    global.day == 2
    && flag_get("missao1_programa")
    && !flag_get("missao1_filmagem")
) {

    dialog_start("Sr. Antonio", [
        "Vamos la, Luisa!",
        "Jogue o mini-game e me ajude com os produtos."
    ]);

    flag_set("iniciar_minigame", true);
    alarm[0] = -1;

    exit;
}

if (
    global.day == 3
    && !flag_get("missao1_completa")
) {

    flag_set("missao1_completa", true);

    dialog_start("Sr. Antonio", [
        "Luisa, deu certo!",
        "Muita gente assistiu ao programa.",
        "Algumas pessoas ate pediram desculpas",
        "pelo jeito que falavam da vida no campo.",
        "Voce ajudou a mostrar que o produtor rural merece respeito."
    ]);

    exit;
}

if (flag_get("missao1_completa")) {

    dialog_start("Sr. Antonio", [
        "As coisas estao andando muito bem por aqui!",
        "Os novos funcionarios sao otimos.",
        "A Mimosa ate fez amizade com um deles."
    ]);

    exit;
}

dialog_start("Sr. Antonio", [
    "Bom te ver por aqui, Luisa.",
    "A fazenda sempre precisa de gente com coragem."
]);