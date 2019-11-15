/// @description Check & set new visibility

// Update visibility with a large margin in case camera moves fast.
visible = point_on_camera_wide(x, y, abs(sprite_width) + 64, abs(sprite_height) + 64 + z_height);