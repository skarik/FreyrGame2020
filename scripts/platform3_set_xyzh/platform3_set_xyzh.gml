/// @description platform3_set_xyzh(platform, new_x, new_y, new_z, z_offset)
/// @param platform
/// @param new_x
/// @param new_y
/// @param new_z
/// @param z_offset

var platform = argument0;
platform.x_requested = argument1;
platform.y_requested = argument2;
platform.y_requestedOffset = -argument4;
platform.z_requested = argument3 + argument4;