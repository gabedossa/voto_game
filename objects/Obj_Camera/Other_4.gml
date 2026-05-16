// obj_camera — Room Start Event
// Reconfigura os limites e snap ao entrar numa nova room
cam_bound_x1 = 0;
cam_bound_y1 = 0;
cam_bound_x2 = room_width;
cam_bound_y2 = room_height;

// Teletransporta câmera para o player imediatamente (sem slide)
camera_snap();

// Garante que a view está ativa
view_enabled    = true;
view_visible[0] = true;
camera_set_view_size(view_camera[0], cam_w, cam_h);
