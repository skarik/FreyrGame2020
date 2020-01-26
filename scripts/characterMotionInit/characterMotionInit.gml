xspeed = 0;
yspeed = 0;
zspeed = 0;
time_off_ground = 0.0;

isAttacking = false;
m_isStunned = false;
isBusyInteracting = false;

#region Constants

kKickbackAmount = 1.0;

kMoveSpeed = 120;
kMoveSpeedStunPercent = 0.05;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedTarPercent = 0.20;

kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;

#endregion

#region Common States

canMove = true; // Externally set!
inWater = false;
inTar = false;
onGround = false;
moEnabled = true;
moCanMoveUnstuck = true;

moHitWall = false;

moScriptOverride = null; // Current motion script override

#endregion