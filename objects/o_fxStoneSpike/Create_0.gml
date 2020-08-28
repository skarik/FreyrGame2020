/// @description Set up depth

depthInit();
z = collision3_get_highest_position(x, y, z);
depthUpdate();

fadeDelay = 0.3;