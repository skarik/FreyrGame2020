/// @description select size

image_index = choose(0, 0, 0, 1);
image_speed = 0;

image_blend = merge_color(c_gold, c_red, 0.5);
light_blend = c_white
image_alpha = choose(1.0, 1.0, 1.0, 0.5, 2.0) * 2.0;

xspeed_base = random_range(5, 60);
yspeed_base = random_range(50, 100);

depthInit();