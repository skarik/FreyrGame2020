/// @description Set up visuals

m_flash = true;
m_flashTimer = 0.1;
m_fadeSpeed = random_range(0.3, 0.6);

image_speed = 0.0;
image_index = floor(random(image_number));
image_xscale *= choose(1.0, -1.0);

xspeed = 0;
yspeed = 0;

z_height = 0;

emissive = instance_create_depth(x, y, depth, o_lightEmissiveDepth);
emissive.target = id;