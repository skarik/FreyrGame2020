/// @description Set sprites and init

kAnimStand = s_charBirdStand;
kAnimFly = s_charBirdFly;
animationIndex = 0.0;

// Init depth
depthInit();

kBoidStateIdle = 0;
kBoidStateFly = 1;
aiState = kBoidStateIdle;
aiFlyTimer = 0;

xspeed = 0.0;
yspeed = 0.0;
boidDirection = 0.0;
boidDirectionAccel = 0.0;

m_initialized = false;

alarm[0] = 1;

isPassthru = true;