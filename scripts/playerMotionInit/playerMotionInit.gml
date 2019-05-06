#region Constants

kMoveSpeed = 120;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedBlockingPercent = 0.50;
kMoveSpeedCarryingPercent = 0.50;
kMoveSpeedDeathtarPercent = 0.25;
kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;
kDashDistance = 48;
kDashTime = 0.15; // movespeed of about 240
kDashCooldown = 0.5;

#endregion

canMove = true; // Externally set!
inWater = false;
isBusyInteracting = false; // Controlled by script
isBlocking = false;
isDashing = false;
onGround = false;

dashStartX = 0.0;
dashStartY = 0.0;
dashTargetX = 0.0;
dashTargetY = 0.0;
dashTimer = 0.0;
dashCooldown = 0.0;

isAttacking = false;
meleeAtkQueued = false;
meleeDashQueued = false;
meleeAtkTimer = 0.0;
meleeAtkCurrent = 0;
meleeAtkDirection = 0;

meleeAtk0Time = 0.2;
meleeAtk0Hit = 0.05;
meleeAtk0Key = 0.10;
meleeAtk0Script = _playerAttack0;
meleeAtk0Damage = 2;

meleeAtk1Time = 0.2;
meleeAtk1Hit = 0.05;
meleeAtk1Key = 0.10;
meleeAtk1Script = _playerAttack1;
meleeAtk1Damage = 2;

meleeAtk2Time = 0.5;
meleeAtk2Hit = 0.1;
meleeAtk2Key = 0.3;
meleeAtk2Script = _playerAttack2;
meleeAtk2Damage = 2;

meleeAtk3Time = 0.4;
meleeAtk3Hit = 0.2;
meleeAtk3Key = 0.21;
meleeAtk3Script = _playerAttack3;
meleeAtk3Damage = 5;
