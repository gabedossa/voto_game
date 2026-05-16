function animal_new_day() {
    if (!fed_today) {
        hunger    += 20;
        happiness -= 15;
    } else {
        hunger    = max(0, hunger - 30);
        happiness = min(100, happiness + 10);
    }
    fed_today = false;
    hunger    = clamp(hunger, 0, 100);
    happiness = clamp(happiness, 0, 100);
    day_counter++;
    if (day_counter >= days_to_product && happiness >= 40) {
        product_ready = true;
        day_counter   = 0;
    }
}

function animal_feed() {
    var _nome;
    if (is_undefined(animal_name)) { _nome = "o animal"; } else { _nome = animal_name; }

    if (fed_today) {
        dialog_start(_nome, ["Ja comi hoje, obrigado!"]);
        exit;
    }
    if (!has_item("Racao")) {
        dialog_start(_nome, ["..."]);
        dialog_start("Luisa", ["Preciso de racao para alimentar " + _nome + "."]);
        exit;
    }
    remove_item("Racao");
    fed_today = true;
    happiness = min(100, happiness + 5);
    hunger    = max(0, hunger - 50);
    use_energy(5);
    dialog_start(_nome, ["Mmmm! Delicioso, obrigado!"]);
}

function animal_collect() {
    var _nome;
    if (is_undefined(animal_name)) { _nome = "o animal"; } else { _nome = animal_name; }

    // CORRIGIDO: verifica product_item antes de usar
    var _produto;
    if (is_undefined(product_item)) { _produto = "item"; } else { _produto = product_item; }

    if (!product_ready) {
        dialog_start(_nome, ["Ainda nao tenho nada pra voce hoje."]);
        exit;
    }
    give_item(_produto);
    product_ready = false;
    use_energy(3);
}

function animal_draw_status() {
    var _bw  = 40;
    var _bh  = 5;
    var _bx  = x - _bw / 2;
    var _by  = y - sprite_height / 2 - 10;
    var _pct = happiness / 100;

    var _col;
    if (_pct > 0.5) {
        _col = make_color_rgb(80, 200, 120);
    } else if (_pct > 0.25) {
        _col = make_color_rgb(240, 180, 40);
    } else {
        _col = make_color_rgb(220, 60, 60);
    }

    draw_set_color(make_color_rgb(40, 40, 50));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    draw_set_color(_col);
    if (_pct > 0) draw_rectangle(_bx, _by, _bx + _bw * _pct, _by + _bh, false);

    if (product_ready) {
        draw_set_color(make_color_rgb(255, 220, 80));
        draw_set_font(fnt_small);
        draw_text(x - 8, y - sprite_height / 2 - 22, "!");
    }
}