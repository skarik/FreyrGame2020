/// @description Create glow and set up depth
emissive = new(o_lightEmissiveDepth_Glow2);
emissive.target = id;
emissive.mask = true;

depthInit();

event_inherited();