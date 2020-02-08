/// @description Draw light with emissive

var dx, dy;
dx = round(x) - 0.5 + xoffset;
dy = round(y) - 3 + yoffset;
draw_set_color(merge_color(c_dkgray, c_white, saturate(energyPower)));
draw_circle(dx, round(dy - z_height), round(energyPower * 4.0), false);
draw_circle(dx, round(dy - z_height), round(energyPower * 6.0), true);