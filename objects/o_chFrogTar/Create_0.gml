/// @description Set sprites

kAnimStanding = s_charFrogTarStand;
kAnimHopping = s_charFrogTarHop;
kAnimSpeedStanding = random_range(8, 11);
kAnimSpeedHop = 7.0;
animationIndex = 0.0;

kFrogStateIdle = 0;
kFrogStateHop = 1;
kFrogStateFly = 2;
aiState = kFrogStateIdle;

kScareDistance = 40.0;

xspeed = 0.0;
yspeed = 0.0;
zspeed = 0.0;

depthInit();