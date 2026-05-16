// =============================================================
//  obj_animal_vaca — User Defined Event (interact)
//  E = alimentar   |   Shift + E = coletar leite
// =============================================================

function interact() {
    if (keyboard_check(vk_shift)) {
        animal_collect();
    } else {
        animal_feed();
    }
}
