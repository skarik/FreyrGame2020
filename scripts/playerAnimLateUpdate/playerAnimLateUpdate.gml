function playerAnimLateUpdate() {
	//
	// Offset Update
	if (onGround)
	{
		moAnimationYOffsetSpeed = 256.0;
	}
	else
	{
		moAnimationYOffsetSpeed = clamp(moAnimationYOffsetSpeed - Time.deltaTime *  256.0, 16.0, 128.0);
	}
	moAnimationYOffset = motion1d_to(moAnimationYOffset, 0.0, moAnimationYOffsetSpeed * Time.deltaTime);

	//
	// Angle Update

	// update facing
	if (!isBusyInteracting && abs(xAxis.value) + abs(yAxis.value) > 0.1)
	{
		if (abs(xAxis.value) * 1.1 > abs(yAxis.value))
		{
			facingIndex = (xAxis.value > 0) ? 1 : 3;	
		}
		else
		{
			facingIndex = (yAxis.value > 0) ? 0 : 2;	
		}
	}

	// update facing direction
	if (moEnabled)
	{
		if (isAttacking)
		{
			facingDirection = meleeAtkDirection;
		}
		else if (moScriptOverride == _playerMoYeetChargeup)
		{
			// Override with aiming also if charging attack
			facingDirection = aimingDirection;
		}
		else
		{
			if (!isBusyInteracting && abs(xAxis.value) + abs(yAxis.value) > 0.1)
			{
				facingDirection = point_direction(0, 0, xAxis.value, yAxis.value);
			}
			// override facing direction with the aiming when standing or attacking, and the mouse moves
			//if (lastControlType == kControlKB || lastControlType == kControlMouse)
			if (uvPositionStyle == kControlUvStyle_Mouse || uvPositionStyle == kControlUvStyle_FakeMouse)
			{
				if (sqr(xspeed) + sqr(yspeed) < 10
				    && (uPosition != uPositionPrevious || vPosition != vPositionPrevious))
				{
					facingDirection = aimingDirection;
				}
			}
			//else if (lastControlType == kControlGamepad)
			else if (uvPositionStyle == kControlUvStyle_Unused)
			{
				if (sqr(xspeed) + sqr(yspeed) < 10
				    && (abs(uAxis.value) > 0.1 || abs(vAxis.value) > 0.1))
				{
					facingDirection = aimingDirection;
				}
			}
		}
	}
	// Need a new one for locked facing while moving!
	/*else
	{
		aimingDirection = facingDirection;
	}*/
	// always update the facing direction, though
	facingIndex = warpi(round(facingDirection / 90) + 1, 0, 4);

	// Hack for running anim
	if (kAnimRunning == kAnimInvalid) {
		kAnimRunning = kAnimWalking;
	}

	//
	// Animation Select
	if (!moAnimationPlayback)
	{
		if (moAnimationExternal)
		{
			// Nothing
		}
		else if (m_isDead)
		{
			sprite_index = kAnimKOed;
			animationSpeed = 0.0;
		}
		else if (m_isKOed)
		{
			if (onGround)
			{
				sprite_index = kAnimKOed;
			}
			else
			{
				sprite_index = kAnimStun; // TODO
			}
			animationSpeed = 3.0;
		}
		else if (m_isStunned)
		{
			sprite_index = kAnimStun;
			animationSpeed = 5.0;
		}
		else if (isDashing)
		{
			sprite_index = kAnimRolling;
			animationSpeed = 0.0;
			animationIndex = floor((image_number / 4.0 - 0.01) * saturate(dashTimer / kDashTime));
		}
		else if (isAttacking)
		{
			animationSpeed = 0.0;
			// animation handled in movestate (dumbly)
		}
		else if (m_isPlayer && m_isTilling)
		{
			sprite_index = kAnimDig1;
			animationSpeed = 0.0;
			animationIndex = floor((image_number / 4.0 - 0.01) * saturate(m_till_timer));
		}
		else if (m_isPlayer && m_isPlanting)
		{
			sprite_index = kAnimDig1;
			animationSpeed = 0.0;
			animationIndex = floor((image_number / 4.0 - 0.01) * saturate(m_plant_timer));
		}
		else if (m_isPlayer && m_isHarvesting)
		{
			sprite_index = kAnimHarvest1;
			animationSpeed = 0.0;
			animationIndex = floor((image_number / 4.0 - 0.01) * saturate(m_harvest_timer));
		}
		else
		{
			var move_speed = sqrt(sqr(xspeed) + sqr(yspeed));
			if (move_speed < 2.0)
			{
				sprite_index = kAnimStanding;
				//animationIndex = 0.0;
				animationSpeed = 0.0;
			}
			else if (move_speed < kMoveSpeed * 0.866)
			{
				sprite_index = kAnimWalking;
				animationSpeed = 14.0          // Start with 12 to 14 FPS
					* move_speed / kMoveSpeed  // Base it on the movespeed
					* (image_number / 24.0);   // Scale up for more frames in the walk animation, assuming 12 FPS 6-cycle
			}
			else
			{
				sprite_index = kAnimRunning;
				animationSpeed = 14.0          // Start with 12 to 14 FPS
					* move_speed / kMoveSpeed  // Base it on the movespeed
					* (image_number / 32.0);   // Scale up for more frames in the walk animation, assuming 12 FPS 8-cycle
			}
		}
	}
	else
	{
		// set animation playback externally
	}

	//
	// Animation Update

	// update sprite
	var animationIndexPrev = animationIndex;
	animationIndex += animationSpeed * Time.deltaTime;

	// Do different animation depending on the number of images (3 versus 4)
	if (!moAnimationPlayback)
	{
		if ((image_number % 3) == 0 && (image_number % 4) != 0)
		{
			image_index = animationIndex % (image_number / 3);
			if (facingIndex == 1 || facingIndex == 3)
				image_index += 2 * image_number / 3;
			else if (facingIndex == 2)
				image_index += image_number / 3;
			if (facingIndex == 1)
				image_xscale = -1;
			else
				image_xscale = +1;
		}
		else if (image_number % 4 == 0)
		{
			// 0 - 270, 1 - 0, 2 - 90, 3 - 180
			image_index = animationIndex % (image_number / 4);
			if (facingIndex == 1)
				image_index += 3 * image_number / 4;
			else if (facingIndex == 3)
				image_index += 2 * image_number / 4;
			else if (facingIndex == 2)
				image_index += 1 * image_number / 4;
		}
	}
	else
	{
		if (moAnimationPlaybackLooped)
		{
			image_index = animationIndex % image_number;
		}
		else
		{
			image_index = clamp(animationIndex, 0.0, image_number - 1.0);
			if (moAnimationPlaybackEndOnFinish && animationIndex >= image_number)
			{
				moAnimationPlaybackEndOnFinish = false;
				moAnimationPlayback = false;
			
			}
		}
	}

	// 
	// Animation effects
	if (sprite_index == kAnimWalking || sprite_index == kAnimRunning)
	{
		var walkBasis = max(1.0, floor(image_number / 4));
		var point0 = animationIndexPrev % walkBasis;
		var point1 = animationIndex % walkBasis;
	
		if ((point0 < walkBasis * 0.25 && point1 >= walkBasis * 0.25)
			|| (point0 < walkBasis * 0.75 && point1 >= walkBasis * 0.75))
		{
			effectOnGroundStep(x, y, point_direction(0, 0, xspeed, yspeed));
		}
	
		stepContinuousTimer += Time.deltaTime * 10.0;
		if (stepContinuousTimer > 1.0)
		{
			effectOnGroundStepContinuous(x, y, point_direction(0, 0, xspeed, yspeed));
			stepContinuousTimer = min(1.0, stepContinuousTimer - 1.0);
		}
	}


}
