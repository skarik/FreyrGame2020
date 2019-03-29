#region Constants

kMoveSpeed = 120;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedBlockingPercent = 0.50;
kMoveSpeedCarryingPercent = 0.50;
kMoveSpeedDeathtarPercent = 0.25;
kMoveAcceleration = 800;
kMoveAccelerationStop = 500;

#endregion

canMove = true; // Externally set!
inWater = false;
isBusyInteracting = false; // Controlled by script
isBlocking = false;

xspeed = 0;
yspeed = 0;
