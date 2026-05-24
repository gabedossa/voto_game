// =============================================================
//  obj_menu_controller — Draw GUI Event
// =============================================================

var _W  = display_get_gui_width();
var _H  = display_get_gui_height();
var _cx = _W / 2;
var _cy = _H / 2;

var _fnt_bold   = asset_get_index("fnt_normal");
var _fnt_normal = asset_get_index("fnt_normal");
var _fnt_small  = asset_get_index("fnt_normal");


// ── Fundo ─────────────────────────────────────────────────────
var spr_bg = asset_get_index("Fundo_jogo");

if (spr_bg >= 0) {
    draw_sprite_stretched(spr_bg, 0, 0, 0, _W, _H);
}

for (var i = 0; i < 20; i++) {
    var _a = (1 - i / 20) * 0.5;
    draw_set_alpha(_a * 0.4);
    draw_set_color(make_color_rgb(40, 80, 50));
    draw_rectangle(0, _H * (i / 20), _W, _H * ((i + 1) / 20), false);
}

draw_set_alpha(1);


// ── Partículas ────────────────────────────────────────────────
for (var i = 0; i < array_length(particles); i++) {
    var _p = particles[i];

    draw_set_alpha(_p.alpha * anim_t);
    draw_set_color(make_color_rgb(100, 200, 120));
    draw_circle(_p.x, _p.y, _p.size, false);
}

draw_set_alpha(1);


// ── Vinheta ───────────────────────────────────────────────────
for (var r = 0; r < 6; r++) {
    draw_set_alpha(0.04);
    draw_set_color(c_black);
    draw_rectangle(r * 15, r * 10, _W - r * 15, _H - r * 10, true);
}

draw_set_alpha(1);


// ── Logo ──────────────────────────────────────────────────────
var _logo_y      = _cy - 180 + (1 - anim_t) * 15;
var _subtitulo_y = _logo_y;

draw_set_alpha(anim_t);

var _spr_logo = asset_get_index("spr_menu_logo");

if (_spr_logo >= 0) {
    var _logo_w = sprite_get_width(_spr_logo);
    var _logo_h = sprite_get_height(_spr_logo);
    var _escala = min(2, 650 / _logo_w);

    var _draw_x = _cx - (_logo_w * _escala) / 2;
    var _draw_y = _logo_y - (_logo_h * _escala) / 2;

    draw_sprite_ext(_spr_logo, 0, _draw_x, _draw_y, _escala, _escala, 0, c_white, anim_t);

    _subtitulo_y = _draw_y + (_logo_h * _escala);
} else {
    draw_set_halign(fa_center);
    draw_set_font(_fnt_bold);

    draw_set_color(make_color_rgb(0, 40, 10));
    draw_text_transformed(_cx + 3, _logo_y + 3, "Terra & Vida", 1, 1, 0);

    draw_set_color(make_color_rgb(220, 240, 180));
    draw_text_transformed(_cx, _logo_y, "Terra & Vida", 1, 1, 0);

    _subtitulo_y = _logo_y + 40;
}


// ── Subtítulo centralizado abaixo da logo ─────────────────────
draw_set_font(_fnt_bold);
draw_set_color(make_color_rgb(195, 212, 184));
draw_set_halign(fa_center);
draw_text_transformed(_cx, _subtitulo_y - 256, "Cultive progresso. Colha prosperidade", 1.4, 1.4, 0);

draw_set_alpha(1);


// ── Painel amadeirado dos botões ──────────────────────────────
if (menu_state == "main") {
    var _btn_labels = [
        loc("menu_new_game"),
        loc("menu_load"),
        loc("menu_quit")
    ];

    var _btn_h    = 40;
    var _btn_gap  = 8;
    var _btn_w    = 260;
    var _painel_w = _btn_w + 40;
    var _painel_h = array_length(_btn_labels) * (_btn_h + _btn_gap) + 30;
    var _painel_x = _cx - _painel_w / 2;
    var _painel_y = _subtitulo_y + 28;

    // Fundo amadeirado
    draw_set_alpha(0.95 * anim_t);
    draw_set_color(make_color_rgb(100, 65, 30));
    draw_roundrect_ext(_painel_x, _painel_y, _painel_x + _painel_w, _painel_y + _painel_h, 10, 10, false);

    // Veios da madeira
    draw_set_alpha(0.08 * anim_t);

    for (var wy = 0; wy < _painel_h; wy += 5) {
        var _wc;

        if (wy mod 10 == 0) {
            _wc = make_color_rgb(60, 35, 10);
        } else {
            _wc = make_color_rgb(140, 95, 45);
        }

        draw_set_color(_wc);
        draw_rectangle(_painel_x + 6, _painel_y + wy, _painel_x + _painel_w - 6, _painel_y + wy + 2, false);
    }

    // Borda externa dourada
    draw_set_alpha(0.9 * anim_t);
    draw_set_color(make_color_rgb(200, 150, 60));
    draw_roundrect_ext(_painel_x, _painel_y, _painel_x + _painel_w, _painel_y + _painel_h, 10, 10, true);

    // Borda interna clara
    draw_set_alpha(0.4 * anim_t);
    draw_set_color(make_color_rgb(240, 200, 100));
    draw_roundrect_ext(_painel_x + 3, _painel_y + 3, _painel_x + _painel_w - 3, _painel_y + _painel_h - 3, 8, 8, true);

    draw_set_alpha(1);


    // ── Botões ────────────────────────────────────────────────
    for (var i = 0; i < array_length(_btn_labels); i++) {
        var _by       = _painel_y + 15 + i * (_btn_h + _btn_gap);
        var _bx       = _cx - _btn_w / 2;
        var _active   = (selected_option == i);
        var _disabled = (i == 1 && !save_exists);
        var _slide    = lerp(_W * 0.08, 0, power(anim_t, 0.5 + i * 0.1));

        _bx += _slide;

        // Fundo do botão
        if (_active) {
            draw_set_alpha(0.9 * anim_t);
            draw_set_color(make_color_rgb(180, 120, 40));
        } else if (_disabled) {
            draw_set_alpha(0.3 * anim_t);
            draw_set_color(make_color_rgb(80, 55, 25));
        } else {
            draw_set_alpha(0.5 * anim_t);
            draw_set_color(make_color_rgb(130, 85, 35));
        }

        draw_roundrect_ext(_bx, _by, _bx + _btn_w, _by + _btn_h, 6, 6, false);

        // Borda do botão ativo
        if (_active) {
            draw_set_alpha(anim_t);
            draw_set_color(make_color_rgb(255, 210, 100));
            draw_roundrect_ext(_bx, _by, _bx + _btn_w, _by + _btn_h, 6, 6, true);
        }

        draw_set_alpha(1);

        // Seta indicadora
        if (_active) {
            draw_set_font(_fnt_bold);
            draw_set_color(make_color_rgb(255, 220, 100));
            draw_set_alpha(anim_t);
            draw_set_halign(fa_left);
            draw_text(_bx + 10, _by + (_btn_h / 2) - 8, ">");
        }

        // Texto do botão
        draw_set_font(_fnt_bold);
        draw_set_alpha(anim_t);

        if (_disabled) {
            draw_set_color(make_color_rgb(120, 90, 55));
        } else if (_active) {
            draw_set_color(make_color_rgb(255, 240, 180));
        } else {
            draw_set_color(make_color_rgb(220, 190, 130));
        }

        draw_set_halign(fa_center);
        draw_text_transformed(_cx + _slide, _by + (_btn_h / 2) - 8, _btn_labels[i], 1, 1, 0);

        draw_set_alpha(1);
    }

    // Hint de controles
    draw_set_alpha(0.5 * anim_t);
    draw_set_font(_fnt_small);
    draw_set_color(make_color_rgb(150, 200, 130));
    draw_set_halign(fa_center);
    draw_text_transformed(_cx, _H - 30, "Cima/Baixo Navegar   Enter Selecionar", 1, 1, 0);

    draw_set_alpha(1);
}

// ── Confirmações ──────────────────────────────────────────────
if (menu_state == "confirm_new" || menu_state == "confirm_quit") {
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _W, _H, false);
    draw_set_alpha(1);

    var _pw = 380;
    var _ph = 160;
    var _px = _cx - _pw / 2;
    var _py = _cy - _ph / 2;

    draw_set_color(make_color_rgb(100, 65, 30));
    draw_roundrect_ext(_px, _py, _px + _pw, _py + _ph, 10, 10, false);

    draw_set_alpha(0.08);

    for (var wy = 0; wy < _ph; wy += 5) {
        var _wood_color_confirm;

        if (wy mod 10 == 0) {
            _wood_color_confirm = make_color_rgb(60, 35, 10);
        } else {
            _wood_color_confirm = make_color_rgb(140, 95, 45);
        }

        draw_set_color(_wood_color_confirm);
        draw_rectangle(_px + 4, _py + wy, _px + _pw - 4, _py + wy + 2, false);
    }

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(200, 150, 60));
    draw_roundrect_ext(_px, _py, _px + _pw, _py + _ph, 10, 10, true);

    var _msg = "";

    if (menu_state == "confirm_new") {
        _msg = loc("confirm_new_game");
    } else {
        _msg = loc("confirm_quit");
    }

    draw_set_font(_fnt_normal);
    draw_set_color(make_color_rgb(255, 230, 180));
    draw_set_halign(fa_center);
    draw_text_ext_transformed(_cx, _py + 40, _msg, 20, _pw - 40, 1, 1, 0);

    var _opts = [
        loc("confirm_yes"),
        loc("confirm_no")
    ];

    for (var i = 0; i < 2; i++) {
        var _bx2 = _px + 50 + i * 190;
        var _by2 = _py + _ph - 55;
        var _act = (selected_option == i);

        if (_act) {
            draw_set_alpha(0.9);

            if (i == 0) {
                draw_set_color(make_color_rgb(160, 60, 40));
            } else {
                draw_set_color(make_color_rgb(50, 120, 60));
            }
        } else {
            draw_set_alpha(0.4);
            draw_set_color(make_color_rgb(80, 55, 25));
        }

        draw_roundrect_ext(_bx2, _by2, _bx2 + 120, _by2 + 32, 6, 6, false);
        draw_set_alpha(1);

        draw_set_font(_fnt_bold);

        if (_act) {
            draw_set_color(c_white);
        } else {
            draw_set_color(make_color_rgb(180, 150, 100));
        }

        draw_set_halign(fa_center);
        draw_text_transformed(_bx2 + 60, _by2 + 8, _opts[i], 1, 1, 0);
    }
}


// ── Versão ────────────────────────────────────────────────────
draw_set_alpha(0.3);
draw_set_font(_fnt_small);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(8, _H - 18, "v1.0");

draw_set_alpha(1);
draw_set_halign(fa_left);
