// =============================================================
//  scr_shop.gml
// =============================================================

function shop_buy(_item_name, _price) {
    if (global.money >= _price) {
        global.money -= _price;
        give_item(_item_name);
        dialog_start("Loja", [
            "Aqui esta! Volte sempre."
        ]);
    } else {
        dialog_start("Loja", [
            "Voce nao tem dinheiro suficiente...",
            "Precisa de $" + string(_price) + " mas tem $" + string(global.money) + "."
        ]);
    }
}

function shop_sell(_item_name, _price) {
    if (has_item(_item_name)) {
        remove_item(_item_name);
        global.money += _price;
        dialog_start("Loja", [
            "Obrigado! Aqui estao seus $" + string(_price) + ".",
            "Saldo atual: $" + string(global.money) + "."
        ]);
    } else {
        dialog_start("Loja", [
            "Voce nao tem " + _item_name + " para vender."
        ]);
    }
}

function money_draw() {
    // CORRIGIDO: usa asset_get_index para a fonte
    var _fnt_normal = asset_get_index("fnt_normal");
    var _W = display_get_gui_width();

    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_roundrect(_W - 145, 54, _W - 8, 78, 6);
    draw_set_alpha(1);

    draw_set_color(make_color_rgb(100, 220, 100));
    draw_set_font(_fnt_normal);
    draw_text(_W - 133, 60, "$ " + string(global.money));
}