var l_canMove = canMove && !m_isDead && !m_isStunned && !isBusyInteracting;

// Do dashing
if (dashCooldown <= 0.0)
{
	if (cButton.pressed && !isDashing && l_canMove && !isAttacking && !exists(currentHeldUsable))
	{
		_playerInteractDoDash();
	}
}
else if (!isDashing)
{
	dashCooldown -= Time.deltaTime;
}
// Do blocking
if (cButton.down && l_canMove && !m_isHolding && !m_isTilling && !m_isPlanting && !exists(currentHeldUsable))
{
	isBlocking = true;
}
else
{
	isBlocking = false;
}

// Inventory selection!
if (l_canMove)
{
	if (lButton.pressed)
	{
		inventory.belt_selection -= 1;
		if (inventory.belt_selection < 0) {
			inventory.belt_selection += inventory.belt_size;
		}
	}
	if (rButton.pressed)
	{
		inventory.belt_selection += 1;
		if (inventory.belt_selection >= inventory.belt_size) {
			inventory.belt_selection -= inventory.belt_size;
		}
	}
}

// update aiming
aimingStartX = x;
aimingStartY = y - (aimingHeight + z_height);
if (l_canMove)
{
	if (uPosition != uPositionPrevious || vPosition != vPositionPrevious)
	{
		aimingDirection = point_direction(aimingStartX, aimingStartY, uPosition, vPosition);
	}
}

// update book
if (l_canMove)
{
	if (xButton.pressed)
	{
		o_PlayerHud.m_book_enabled = !o_PlayerHud.m_book_enabled; // todo: make this a cutscene menu
	}
}

_playerInteractTillables(l_canMove && !inDelayFrame);
_playerInteractUsables(l_canMove && !inDelayFrame);
_playerInteractCrops(l_canMove && !inDelayFrame);
//_playerInteractBuildables();
_playerInteractItems(l_canMove && !inDelayFrame);

var belt = inventory.belt[inventory.belt_selection];
if (belt.type == kItemPickupSeed) {
	_playerInteractPlantables(l_canMove && !inDelayFrame);
}

// do combat mode calculations
inCombatMode = !inDelayFrame;
//if (collision_circle(x, y, )
// todo: loop thru near enemies, if they're hostile, then we in combat mode
if (exists(currentUsable) || exists(currentHeldUsable))
{
	inCombatMode = false;
}
if (exists(currentCrop))
{
	inCombatMode = false;
}
if (exists(currentTillable) || m_isTilling)
{
	inCombatMode = false;
}

// update attacking
if (l_canMove && !isDashing && !isBlocking)
{
	if (!isAttacking)
	{
		meleeAtkTimer += Time.deltaTime * 2.0;
		
		if (bButton.pressed && inCombatMode)
		{
			if (meleeAtkTimer > 1.0)
			{
				meleeAtkCurrent = 0;
				// do the thing
				meleeAtkTimer = 0.0;
				isAttacking = true;
				isDashing = false;
				meleeAtkDirection = aimingDirection;
			}
			else if (meleeAtkCurrent < 3)
			{
				meleeAtkCurrent += 1;
				// do the thing
				meleeAtkTimer = 0.0;
				isAttacking = true;
				isDashing = false;
				meleeAtkDirection = aimingDirection;
			}
			else
			{
				meleeAtkCurrent = 0;
				dashCooldown = -1.0;
				//meleeAtkTimer = +2.0;
			}
		}
		else if (meleeAtkTimer > 1.0)
		{
			meleeAtkCurrent = 0;
		}
	}
	else
	{
		if (cButton.pressed)
		{
			meleeDashQueued = true;
			meleeAtkQueued = false;
		}
		else if (bButton.pressed)
		{
			meleeDashQueued = false;
			meleeAtkQueued = true;
		}
	}
	
	// Combo limiter
	if (meleeAtkCurrent > 3)
	{
		meleeAtkCurrent = 0;
		dashCooldown = -1.0;
		isAttacking = false;
	}
}
else if (isDashing)
{
	meleeAtkTimer = +2.0;
	meleeAtkCurrent = 0;
}

// reset delay frame
inDelayFrame = false;