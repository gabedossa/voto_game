// =============================================================
//  obj_minigame_unboxing — Draw GUI Event
// =============================================================
var _W = display_get_gui_width();
var _H = display_get_gui_height();

// Fundo
draw_set_color(make_color_rgb(30, 30, 40));
draw_rectangle(0, 0, _W, _H, false);

// Caixa principal
draw_set_color(make_color_rgb(180, 130, 70));
draw_rectangle(cx - 80, cy - 80, cx + 80, cy + 80, false);
draw_set_color(make_color_rgb(140, 100, 50));
draw_rectangle(cx - 80, cy - 80, cx + 80, cy + 80, true);

// Fases visuais
switch (fase) {
    case 0: // mostra as 4 fitinhas
        draw_set_color(make_color_rgb(220, 50, 50));
        for (var i = 0; i < fitas_pequenas; i++) {
            draw_rectangle(cx - 70 + i * 16, cy - 85, cx - 58 + i * 16, cy - 75, false);
        }
        // fitas grandes
        draw_set_color(make_color_rgb(220, 50, 50));
        draw_rectangle(cx - 80, cy - 8, cx + 80, cy + 8, false);   // horizontal
        draw_rectangle(cx - 8,  cy - 80, cx + 8, cy + 80, false);  // vertical
    break;

    case 1: // fitinhas removidas, fitas grandes ainda presentes
        draw_set_color(make_color_rgb(220, 50, 50));
        draw_rectangle(cx - 80, cy - 8, cx + 80, cy + 8, false);
        draw_rectangle(cx - 8,  cy - 80, cx + 8, cy + 80, false);
    break;

    case 2: // só a caixa fechada
        draw_set_color(make_color_rgb(255, 200, 80));
        draw_set_font(fnt_bold);
        draw_text_transformed(cx, cy, "ABRIR", 1.5, 1.5, 0);
    break;

    case 3: // papel bolha
        draw_set_color(make_color_rgb(180, 230, 255));
        draw_rectangle(cx - 70, cy - 70, cx + 70, cy + 70, false);
        draw_set_color(make_color_rgb(120, 180, 220));
        draw_set_font(fnt_normal);
        draw_text(cx - 50, cy - 10, "Cliques: " + string(bolha_cliques));
    break;

    case 4: // itens revelados
        draw_set_color(make_color_rgb(80, 200, 120));
        draw_set_font(fnt_bold);
        draw_text(cx - 55, cy - 20, "Camera");
        draw_text(cx - 55, cy + 10, "Microfone");
    break;
}

// Instrução na parte de baixo
draw_set_color(make_color_rgb(220, 220, 240));
draw_set_font(fnt_normal);
draw_text_ext(20, _H - 50, instrucao, -1, _W - 40);
