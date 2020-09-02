/// @description Init timers

flameTimer0 = 0.0;
smokeTimer0 = 0.0;

depthInit();
z = collision3_get_highest_position(x, y, z);
z_height = 2;
depthUpdate();
depth -= 8;