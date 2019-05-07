isDashing = true;
dashTimer = 0.0;
dashCooldown = kDashCooldown;
		
dashStartX = x;
dashStartY = y;
dashStartZ = z;
dashStartZ_height = z_height;
dashTargetX = x + lengthdir_x(kDashDistance, facingDirection);
dashTargetY = y + lengthdir_y(kDashDistance, facingDirection);