// =============================================================
//  scr_inventory.gml
//  Sistema de inventário e notificação de itens
// =============================================================

function inventory_init() {
    global.inventory        = [];
    global.item_notif_text  = "";
    global.item_notif_timer = 0;
}

function give_item(_item_name) {
    // CORRIGIDO: garante que o inventário existe antes de usar
    if (!variable_global_exists("inventory") || is_undefined(global.inventory)) {
        global.inventory = [];
    }

    array_push(global.inventory, _item_name);
    global.item_notif_text  = "Item recebido:  " + _item_name;
    global.item_notif_timer = 180;
}

function has_item(_item_name) {
    // CORRIGIDO: garante que o inventário existe antes de usar
    if (!variable_global_exists("inventory") || is_undefined(global.inventory)) {
        global.inventory = [];
    }

    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == _item_name) return true;
    }
    return false;
}

function remove_item(_item_name) {
    // CORRIGIDO: garante que o inventário existe antes de usar
    if (!variable_global_exists("inventory") || is_undefined(global.inventory)) {
        global.inventory = [];
    }

    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == _item_name) {
            array_delete(global.inventory, i, 1);
            return true;
        }
    }
    return false;
}

function inventory_notif_draw() {
    if (!variable_global_exists("item_notif_timer")) exit;
    if (is_undefined(global.item_notif_timer)) exit;
    if (global.item_notif_timer <= 0) exit;

    global.item_notif_timer--;

    var _alpha = min(1.0, global.item_notif_timer / 30.0);
    draw_set_alpha(_alpha);

    draw_set_color(make_color_rgb(20, 20, 30));
    draw_roundrect(14, 58, 340, 90, 6);
    draw_set_color(make_color_rgb(255, 220, 80));
    draw_roundrect(14, 58, 340, 90, 6);

    draw_set_color(make_color_rgb(255, 220, 80));
    draw_set_font(fnt_bold);
    draw_text(26, 65, global.item_notif_text);

    draw_set_alpha(1.0);
}
