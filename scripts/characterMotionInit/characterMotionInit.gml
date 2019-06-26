xspeed = 0;
yspeed = 0;
zspeed = 0;

#region Constants

kMoveSpeed = 120;
kMoveSpeedStunPercent = 0.05;
kMoveSpeedWaterPercent = 0.50;

kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;

#endregion

#region Common States

canMove = true; // Externally set!
inWater = false;
onGround = false;
moEnabled = true;
moAnimationPlayback = false;
moAnimationPlaybackLooped = false;
moCanMoveUnstuck = true;

moScriptOverride = null; // Current motion script override

#endregion