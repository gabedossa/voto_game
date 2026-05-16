// obj_camera — Room Start Event
cam_w          = 320;
cam_h          = 180;
cam_smooth     = 0.12;
cam_x          = 0;
cam_y          = 0;
cam_bound_x1   = 0;
cam_bound_y1   = 0;
cam_bound_x2   = room_width;
cam_bound_y2   = room_height;
cam_shake      = 0;
cam_shake_max  = 0;
cam_shake_dur  = 0;
cam_shake_t    = 0;

if (instance_exists(obj_player)) {
    cam_x = obj_player.x;
    cam_y = obj_player.y;
}

view_enabled    = true;
view_visible[0] = true;
camera_set_view_size(view_camera[0], cam_w, cam_h);