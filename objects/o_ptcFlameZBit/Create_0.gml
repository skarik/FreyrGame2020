/// @description Initialize

depthInit();

image_xscale = choose(1, -1);
image_index = 0;
image_speed = 0;
animationIndex = 0;
animationSpeed = random_range(0.8, 1.2);

emissive = instance_create_depth(x, y, depth, o_lightEmissiveDepth);
emissive.target = id;