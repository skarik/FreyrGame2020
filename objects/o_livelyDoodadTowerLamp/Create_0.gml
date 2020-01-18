/// @description Create glow and set up depth
emissive = new(o_lightEmissiveDepth_User5);
emissive.target = id;
emissive.mask = false;

depthInit();

event_inherited();

lightingPower = 0;