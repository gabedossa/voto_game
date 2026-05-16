if (stage_clear) {

    stage_timer--;

    image_speed = 0;

    if (stage_timer <= 0) {

        global.tp_x = 1167;
        global.tp_y = 896;

        stage_clear = false;
        can_move = true;

        room_goto(rm_overworld);
    }

    exit;
}

if (!can_move) {
    image_speed = 0;
    exit;
}

if (
    room != rm_room_minigame
    && flag_get("iniciar_minigame")
    && (
        !variable_global_exists("dialog_active")
        || !global.dialog_active
    )
) {
    flag_set("iniciar_minigame", false);
    flag_set("missao1_filmagem", true);

    spd_x = 0;
    spd_y = 0;
    can_move = true;

    global.tp_x = 95;
    global.tp_y = 576;

    room_goto(rm_room_minigame);
    exit;
}

if (room == rm_room_minigame) {

    if (place_meeting(x, y, obj_fim_fase)) {

        stage_clear = true;
        stage_timer = room_speed;

        spd_x = 0;
        spd_y = 0;

        can_move = false;

        global.money += moedas * 10;
        moedas = 0;

        exit;
    }

    if (place_meeting(x, y, obj_reset_minigame)) {
        moedas = 0;
        spd_x = 0;
        spd_y = 0;
        global.tp_x = 95;
        global.tp_y = 576;
        room_goto(rm_room_minigame);
        exit;
    }

    spd_x = 0;

    var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var _jump  = keyboard_check_pressed(vk_up)
              || keyboard_check_pressed(vk_space)
              || keyboard_check_pressed(ord("W"));

    if (_left) {
        spd_x = -vel_plataforma;
        sprite_index = spr_luisa_lado;
        image_xscale = 1;
    }

    if (_right) {
        spd_x = vel_plataforma;
        sprite_index = spr_luisa_lado;
        image_xscale = -1;
    }

    var _ground = place_meeting(x, y + 1, obj_wall);

    if (_ground) {
        if (spd_y > 0) {
            spd_y = 0;
        }

        if (_jump) {
            spd_y = forca_pulo;
        }
    } else {
        spd_y += gravidade;
    }

    if (spd_y > 12) {
        spd_y = 12;
    }

    if (place_meeting(x + spd_x, y, obj_wall)) {
        while (!place_meeting(x + sign(spd_x), y, obj_wall)) {
            x += sign(spd_x);
        }

        spd_x = 0;
    }

    x += spd_x;

    if (place_meeting(x, y + spd_y, obj_wall)) {
        while (!place_meeting(x, y + sign(spd_y), obj_wall)) {
            y += sign(spd_y);
        }

        spd_y = 0;
    }

    y += spd_y;

    if (spd_x != 0 && _ground) {
        image_speed = 0.15;
    } else {
        image_speed = 0;
        image_index = 0;
    }

    exit;
}

var _dx = 0;
var _dy = 0;
var _moving = false;

var _left_td  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _right_td = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _up_td    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _down_td  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

if (_left_td) {
    sprite_index = spr_luisa_lado;
    image_xscale = 1;
    _dx = -move_speed;
    facing = 1;
    _moving = true;
}

if (_right_td) {
    sprite_index = spr_luisa_lado;
    image_xscale = -1;
    _dx = move_speed;
    facing = 2;
    _moving = true;
}

if (_up_td) {
    sprite_index = spr_luisa_cima;
    image_xscale = 1;
    _dy = -move_speed;
    facing = 3;
    _moving = true;
}

if (_down_td) {
    sprite_index = spr_luisa_baixo;
    image_xscale = 1;
    _dy = move_speed;
    facing = 0;
    _moving = true;
}

var _running_now = false;

if (keyboard_check(vk_shift) && _moving && global.energy > 0) {

    _running_now = true;

    if (_left_td)  _dx = -running;
    if (_right_td) _dx =  running;
    if (_up_td)    _dy = -running;
    if (_down_td)  _dy =  running;
}

if (_running_now) {

    run_energy_timer++;

    if (run_energy_timer >= room_speed) {

        run_energy_timer = 0;

        use_energy(1);
    }
}
else {
    run_energy_timer = 0;
}

if (_dx != 0 && _dy != 0) {
    _dx *= 0.70710678;
    _dy *= 0.70710678;
}

var _hit_left   = -7;
var _hit_right  =  7;
var _hit_top    =  5;
var _hit_bottom = 14;
var _blockers = [
    obj_wall,
    obj_colisor_8x8,
    obj_npc_antonio,
    obj_npc_antonio_acao
];

var _move_x = _dx;
repeat (ceil(abs(_move_x))) {
    var _step_x = sign(_move_x) * min(abs(_move_x), 1);
    if (_step_x == 0) break;

    var _blocked_x = false;
    var _test_x = x + _step_x;

    for (var _i = 0; _i < array_length(_blockers); _i++) {
        if (
            collision_rectangle(
                _test_x + _hit_left,
                y + _hit_top,
                _test_x + _hit_right,
                y + _hit_bottom,
                _blockers[_i],
                false,
                true
            ) != noone
        ) {
            _blocked_x = true;
            break;
        }
    }

    if (_blocked_x) {
        break;
    }

    x = _test_x;
    _move_x -= _step_x;
}

var _move_y = _dy;
repeat (ceil(abs(_move_y))) {
    var _step_y = sign(_move_y) * min(abs(_move_y), 1);
    if (_step_y == 0) break;

    var _blocked_y = false;
    var _test_y = y + _step_y;

    for (var _j = 0; _j < array_length(_blockers); _j++) {
        if (
            collision_rectangle(
                x + _hit_left,
                _test_y + _hit_top,
                x + _hit_right,
                _test_y + _hit_bottom,
                _blockers[_j],
                false,
                true
            ) != noone
        ) {
            _blocked_y = true;
            break;
        }
    }

    if (_blocked_y) {
        break;
    }

    y = _test_y;
    _move_y -= _step_y;
}

if (_moving) {
    image_speed = 0.15;
} else {
    image_speed = 0;
}

if (!_moving) {
    image_index = 0;
}

if (keyboard_check_pressed(ord("Z"))) {
    if (!global.dialog_active) {

        var _ox = 0;
        var _oy = 0;

        switch (facing) {
            case 0: _oy =  24; break;
            case 1: _ox = -24; break;
            case 2: _ox =  24; break;
            case 3: _oy = -24; break;
        }

        var _antonio = instance_place(x + _ox, y + _oy, obj_npc_antonio_acao);

        if (_antonio == noone) {
            _antonio = instance_place(x + _ox, y + _oy, obj_npc_antonio);
        }

        if (_antonio != noone) {
            with (_antonio) {
                if (object_index == obj_npc_antonio) {
                    if (!variable_instance_exists(id, "talked_today")) {
                        talked_today = false;
                    }

                    event_perform_object(obj_npc_antonio_acao, ev_other, ev_user0);
                } else {
                    event_user(0);
                }
            }
        }

        if (_antonio == noone) {
            var _npc_talk = noone;

            _npc_talk = collision_circle(x + _ox, y + _oy, 28, obj_Ana, false, true);
            if (_npc_talk != noone) {
                dialog_start("Ana", [
                    "O comercio de flores no Brasil e muito rico em variedades,",
                    "mas voce sabia que muitas plantas nao sao apenas decorativas?",
                    "Pelo contrario, muitas possuem outras utilidades,",
                    "como, por exemplo, a babosa.",
                    "Alem de decorativa, ela pode ser usada na producao",
                    "de mascaras de cabelo caseiras."
                ]);
            }

            if (_npc_talk == noone) {
                _npc_talk = collision_circle(x + _ox, y + _oy, 28, obj_Loira, false, true);
                if (_npc_talk != noone) {
                    dialog_start("Loira", [
                        "Antigamente, o queijo era uma forma de nao desperdicar leite,",
                        "ja que ele estraga rapido.",
                        "Transformando em queijo, dava pra conservar por mais tempo,",
                        "tipo uma tecnologia antiga de sobrevivencia.",
                        "Antes do queijo chegar a mesa, tem muito trabalho no campo.",
                        "O agro cuida das vacas que produzem o leite",
                        "que usamos para fazer os queijos."
                    ]);
                }
            }

            if (_npc_talk == noone) {
                _npc_talk = collision_circle(x + _ox, y + _oy, 28, obj_Calvo_barbudo_bravo, false, true);
                if (_npc_talk != noone) {
                    dialog_start("Velho Barbudo", [
                        "A farinha de trigo e um ingrediente essencial",
                        "para a fabricacao de paes.",
                        "Mas para a farinha existir, as plantacoes de trigo",
                        "sao essenciais.",
                        "Sem o agro plantando nosso trigo, seria impossivel",
                        "fazer nosso paezinhos.",
                        "Imagina como seria triste um cafe da manha sem paezinhos."
                    ]);
                }
            }

            if (_npc_talk == noone) {
                _npc_talk = collision_circle(x + _ox, y + _oy, 28, obj_Velhinha, false, true);
                if (_npc_talk != noone) {
                    dialog_start("Velhinha", [
                        "Na promocao de hoje, ao comprar um tambaqui,",
                        "voce ganha um pintado.",
                        "Esses peixes que estao para a venda nao sao apenas peixes,",
                        "sao a fonte de sustento de muitas familias.",
                        "Gracas ao comercio de peixes, posso viver bem",
                        "com a minha familia, e criar meus filhos e netos."
                    ]);
                }
            }
        }
    }
}

if (keyboard_check_pressed(vk_f5)) {
    save_game();
}