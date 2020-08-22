/// @description Delay initialize depth

depthInit();
alarm[0] = 1;

m_fadeTimer = 1.0;
m_fadeSpeed = 0.2;
m_shrinkSpeed = 0.1;

image_xscale = choose(1, -1);
image_speed = random_range(0.8, 1.2);