/// @description Create glow and set up depth
emissive = inew(o_lightEmissiveDepth_Glow2);
emissive.target = id;
emissive.mask = true;
emissive.image_blend = c_towerdiamond;

//depthInit();
z = 0;
z_height = 0;

event_inherited();