/// @description Select particle and init motion

image_speed = 0.0;
image_index = floor(random(image_number));

image_angle = choose(0, 90, 180, 270);
image_xscale = choose(-1, 1);
image_yscale = choose(-1, 1);

particleZMotionInit();

fade = false;

zgravity *= random_range(0.08, 0.35);