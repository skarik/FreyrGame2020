/// @description platform3_set_z(platform, new_z)
/// @param platform
/// @param new_z

var platform = argument0;
platform.z_requested = argument1;

platform.x_requested = platform.x;
platform.y_requested = platform.y;
platform.y_requestedOffset = 0;