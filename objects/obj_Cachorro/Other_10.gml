if (talked_today) {
    dialog_start("Cachorro", [
        "Au Au!"
    ]);
    exit;
}

talked_today = true;

dialog_start("Cachorro", [
    "O agronegócio é o principal motor da economia brasileira,",
"representando cerca de 24% a 25% do PIB nacional.",
"Ele garante a segurança alimentar, sustenta a balança",
"comercial com quase metade das exportações...",
"....quer dizer.....",
"Au Au!"
]);