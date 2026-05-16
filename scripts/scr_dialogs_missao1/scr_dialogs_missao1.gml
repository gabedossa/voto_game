// =============================================================
//  scr_dialogs_missao1.gml
//  Todos os diálogos da Missão 1 organizados por dia
//  Chame a função do dia correto de dentro do obj_npc_antonio
// =============================================================

// ---------------------------------------------------------------
// dialog_antonio_dia1()
// Sr. Antônio explica o problema e Luisa oferece ajuda
// ---------------------------------------------------------------
function dialog_antonio_dia1() {
    dialog_start("Sr. Antonio", [
        "Nao, nao e... adivinha? Tambem nao!",
        "To mais vazio que cabeca de galinha aqui, minha filha.",
        "Ah, desde que o Ze foi embora ta dificil demais.",
        "Esse rapaz sumiu e levou minha produtividade junto!",
        "Pensei em contratar! Mas meu carro resolveu morrer junto com as vendas.",
        "To a pe, literalmente."
    ]);
    // Após esse bloco, chame o seguinte com um alarm ou callback:
    // dialog_antonio_dia1_resposta_luisa()
}

function dialog_antonio_dia1_resposta_luisa() {
    dialog_start("Luisa", [
        "Entao deixa comigo.",
        "Eu levo os cartazes pra voce."
    ]);
}

function dialog_antonio_dia1_agradecimento() {
    dialog_start("Sr. Antonio", [
        "O menina, voce caiu do ceu ou ta perdida?"
    ]);
    dialog_start("Luisa", [
        "As duas coisas, Sr. Antonio!"
    ]);
}

// ---------------------------------------------------------------
// dialog_luisa_geladeira_dia1()
// Pensamento da Luisa ao interagir com a geladeira
// ---------------------------------------------------------------
function dialog_luisa_geladeira_dia1() {
    dialog_start("Luisa", [
        "Hmm... nem uma fruta sobrou.",
        "Ta na hora de dar uma passada na feirinha."
    ]);
}

function dialog_luisa_guardar_compras() {
    dialog_start("Luisa", [
        "Pronto. Agora sim...",
        "Vamos ver se esses cartazes fazem alguma coisa."
    ]);
}

function dialog_luisa_apos_cartazes() {
    dialog_start("Luisa", [
        "Missao cumprida.",
        "Agora e so esperar.",
        "Torcamos."
    ]);
}

// ---------------------------------------------------------------
// dialog_antonio_dia2()
// Ninguém ligou — proposta do programa de TV
// ---------------------------------------------------------------
function dialog_antonio_dia2() {
    dialog_start("Sr. Antonio", [
        "Ligou sim! O vizinho perguntando se eu tinha visto o gato dele.",
        "Nenhuma alma interessada na vaga, minha filha.",
        "O povo tem la suas ideias sobre o campo...",
        "Acham que fazendeiro come fogo e briga com jacare!",
        "Passa tanta coisa estranha na TV que ninguem sabe como e a vida aqui."
    ]);
}

function dialog_luisa_proposta_programa() {
    dialog_start("Luisa", [
        "E se a gente mostrasse como e de verdade?",
        "Meu pai tinha contato numa emissora.",
        "Ainda tenho o numero.",
        "A gente grava um programa, mostra o dia a dia aqui.",
        "Sem drama, sem sensacionalismo."
    ]);
}

function dialog_antonio_aceita_programa() {
    dialog_start("Sr. Antonio", [
        "Programa de TV?! Eu?!",
        "Pelo menos me avisam antes pra eu pentear isso aqui."
    ]);
    dialog_start("Luisa", [
        "Considerado.",
        "Vou ligar agora."
    ]);
}

// ---------------------------------------------------------------
// dialog_aline_cutscene()
// Conversa com Aline da TV
// ---------------------------------------------------------------
function dialog_aline_cutscene() {
    dialog_start("Luisa", [
        "Aline! Tenho uma proposta pra voce."
    ]);
    dialog_start("Aline", [
        "Luisa! Fala logo, voce me conhece,",
        "nao tenho paciencia pra rodeio."
    ]);
    dialog_start("Luisa", [
        "Quero gravar um programa mostrando a vida real no campo.",
        "Trabalho honesto, sem vilao, sem caricatura."
    ]);
    dialog_start("Aline", [
        "Sabe que isso pode funcionar?",
        "Tenho um horario vago que ta sobrando.",
        "Mas camera eu nao tenho como mandar,",
        "equipe toda ocupada."
    ]);
    dialog_start("Luisa", [
        "Eu mesma gravo."
    ]);
    dialog_start("Aline", [
        "E isso que eu gosto em voce, Luisa.",
        "Fala e ja resolve.",
        "Mando os equipamentos ainda hoje."
    ]);
}

// ---------------------------------------------------------------
// dialog_celeiro_filmagem()
// Sr. Antônio na frente da câmera pela primeira vez
// ---------------------------------------------------------------
function dialog_celeiro_filmagem() {
    dialog_start("Sr. Antonio", [
        "Eu to parecendo um idiota na camera?"
    ]);
    dialog_start("Luisa", [
        "O senhor ta otimo.",
        "So fala normal."
    ]);
    dialog_start("Sr. Antonio", [
        "Essa aqui e a Mimosa.",
        "Seis anos, teimosa que so ela.",
        "Todo dia a gente cuida, alimenta, ve se ta bem.",
        "Nao e gado pra mim, nao, e companhia.",
        "Agora nao vou mentir,",
        "ela ja me deu um coice ou dois tambem."
    ]);
    dialog_start("Luisa", [
        "Perfeito.",
        "Continua assim."
    ]);
}

// ---------------------------------------------------------------
// dialog_luisa_email()
// Luisa digitando o e-mail para a Aline
// ---------------------------------------------------------------
function dialog_luisa_email() {
    dialog_start("Luisa", [
        "Aline, ta aqui o material.",
        "Acho que ficou bom de verdade.",
        "O Sr. Antonio tem um talento natural pra isso,",
        "mesmo sem saber.",
        "Qualquer coisa me fala.",
        "— Luisa"
    ]);
}

// ---------------------------------------------------------------
// dialog_antonio_dia3()
// Final da missão — 5 funcionários interessados
// ---------------------------------------------------------------
function dialog_antonio_dia3() {
    dialog_start("Sr. Antonio", [
        "LUISA! Minha filha!",
        "Voce viu o que aconteceu?!"
    ]);
    dialog_start("Luisa", [
        "Boa noticia?"
    ]);
    dialog_start("Sr. Antonio", [
        "Cinco pessoas querendo trabalhar aqui! CINCO!",
        "Meu telefone ficou tao quente que achei que ia derreter!",
        "Uma das meninas disse que sempre quis trabalhar no campo...",
        "Mas achava que nao era bem-vinda.",
        "So precisava ver que tinha espaco pra ela.",
        "Imagina, Luisa..."
    ]);
    dialog_start("Luisa", [
        "As vezes e so isso que falta mesmo."
    ]);
    dialog_start("Sr. Antonio", [
        "Muito obrigado, Luisa.",
        "De verdade.",
        "Toma isso aqui.",
        "E pouco perto do que voce fez,",
        "mas e do coracao."
    ]);
    dialog_start("Luisa", [
        "Obrigada, Sr. Antonio.",
        "Mas e a Mimosa que agradece.",
        "Ela foi a estrela do programa."
    ]);
    dialog_start("Sr. Antonio", [
        "Nao fala isso pra ela que o focinho ja ta grande!"
    ]);

    // Entrega o Ticket Especial e conclui a missão
    give_item("Ticket Especial");
    flag_set("missao1_completa", true);
}
