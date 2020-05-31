var l_canMove = canMove && !m_isDead && !m_isStunned && !isBusyInteracting && !m_usingInventory && !m_usingBook;

// Do dashing
if (dashCooldown <= 0.0)
{
	if (dodgeButton.pressed && !isDashing && l_canMove && onGround && !isAttacking && !iexists(currentHeldUsable))
	{
		_playerInteractDoDash();
	}
}
else if (!isDashing)
{
	dashCooldown -= Time.deltaTime;
}
// Do blocking
if (dodgeButton.down && l_canMove && onGround && !m_isHolding && !m_isTilling && !m_isPlanting && !m_isHarvesting && !iexists(currentHeldUsable))
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
	if (itemPrevButton.pressed)
	{
		if (inventory.belt_selection == null)
			inventory.belt_selection = inventory.belt_size;
		inventory.belt_selection -= 1;
		if (inventory.belt_selection < 0) {
			inventory.belt_selection += inventory.belt_size;
		}
	}
	if (itemNextButton.pressed)
	{
		if (inventory.belt_selection == null)
			inventory.belt_selection = -1;
		inventory.belt_selection += 1;
		if (inventory.belt_selection >= inventory.belt_size) {
			inventory.belt_selection -= inventory.belt_size;
		}
	}
	if (itemUnequipButton.pressed)
	{
		inventory.belt_selection = null;
	}
	
	if (belt1Button.pressed)
		if (inventory.belt_selection == 0)
			inventory.belt_selection = null;
		else
			inventory.belt_selection = 0;
	if (belt2Button.pressed)
		if (inventory.belt_selection == 1)
			inventory.belt_selection = null;
		else
			inventory.belt_selection = 1;
	if (belt3Button.pressed)
		if (inventory.belt_selection == 2)
			inventory.belt_selection = null;
		else
			inventory.belt_selection = 2;
	if (belt4Button.pressed)
		if (inventory.belt_selection == 3)
			inventory.belt_selection = null;
		else
			inventory.belt_selection = 3;
	if (belt5Button.pressed)
		if (inventory.belt_selection == 4)
			inventory.belt_selection = null;
		else
			inventory.belt_selection = 4;
	if (belt6Button.pressed)
		if (inventory.belt_selection == 5)
			inventory.belt_selection = null;
		else
			inventory.belt_selection = 5;
}

// update aiming
aimingStartX = x;
aimingStartY = y - (aimingHeight + z_height);
if (l_canMove)
{
	//if (lastControlType == kControlKB || lastControlType == kControlMouse)
	if (uvPositionStyle == kControlUvStyle_Mouse || uvPositionStyle == kControlUvStyle_FakeMouse)
	{
		if (uPosition != uPositionPrevious || vPosition != vPositionPrevious)
		{
			aimingDirection = point_direction(aimingStartX, aimingStartY, uPosition, vPosition);
		}
	}
	//else if (lastControlType == kControlGamepad)
	else if (uvPositionStyle == kControlUvStyle_Unused)
	{
		if (sqr(uAxis.value) + sqr(vAxis.value) > sqr(0.1))
		{
			aimingDirection = point_direction(0, 0, uAxis.value, vAxis.value);
		}
		else if (sqr(xAxis.value) + sqr(yAxis.value) > sqr(0.05))
		{
			aimingDirection = point_direction(0, 0, xAxis.value, yAxis.value);
		}
	}
}

// update aiming2
aiming2StartX = x;
aiming2StartY = y - (aiming2Height + z_height);
if (l_canMove)
{
	if (lastControlType == kControlKB || lastControlType == kControlMouse)
	{
		if (uPosition != uPositionPrevious || vPosition != vPositionPrevious)
		{
			aiming2Direction = point_direction(aiming2StartX, aiming2StartY, uPosition, vPosition);
		}
	}
	else if (lastControlType == kControlGamepad)
	{
		if (sqr(uAxis.value) + sqr(vAxis.value) > sqr(0.1))
		{
			aiming2Direction = point_direction(0, 0, uAxis.value, vAxis.value);
		}
		else if (sqr(xAxis.value) + sqr(yAxis.value) > sqr(0.05))
		{
			aiming2Direction = point_direction(0, 0, xAxis.value, yAxis.value);
		}
	}
}

// Update book & inventory popups - if using book or inventory then we override the CTS stop stuff.
if (l_canMove || m_usingInventory || m_usingBook)
{
	if (journalButton.pressed)
	{
		//o_PlayerHud.m_book_enabled = !o_PlayerHud.m_book_enabled; // todo: make this a cutscene menu
		m_usingInventory = false; 
		m_usingBook = !m_usingBook;
		if (m_usingBook && !iexists(o_menuPlayerBook))
			inew(o_menuPlayerBook);
	}
	if (itemsButton.pressed)
	{
		m_usingBook = false;
		m_usingInventory = !m_usingInventory;
	}
}
if (!m_usingInventory)
{
	m_currentChest = null; // hack this in for now
}

m_currentInteractionType = kInteractionDefault;

_playerInteractTillables(l_canMove && onGround && !inDelayFrame);
_playerInteractUsables(l_canMove && onGround && !inDelayFrame);
_playerInteractCrops(l_canMove && onGround && !inDelayFrame);
//_playerInteractBuildables();
_playerInteractItems(l_canMove && !inDelayFrame);
_playerInteractItemsKeySlot(l_canMove && !inDelayFrame);
_playerInteractItemsRuneSlot(l_canMove && !inDelayFrame);

var belt;
if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
	belt = inventory.belt[inventory.belt_selection];
else
	belt = null;
if (belt != null && belt.type == kItemPickupSeed) {
	_playerInteractPlantables(l_canMove && onGround && !inDelayFrame);
}

// not planting if not in animation
//if (!moAnimationPlayback) {
//	m_isPlanting = false;
//} // Shitty hack anyways

// do combat mode calculations
inCombatMode = !inDelayFrame;
//if (collision_circle(x, y, )
// todo: loop thru near enemies, if they're hostile, then we in combat mode
if (iexists(currentUsable) || iexists(currentHeldUsable))
{
	inCombatMode = false;
}
if (iexists(currentCrop))
{
	inCombatMode = false;
}
if (iexists(currentTillable) || m_isTilling)
{
	inCombatMode = false;
}
if (m_isHarvesting)
{
	inCombatMode = false;
}

if (inCombatMode && m_currentInteractionType == kInteractionDefault)
{
	m_currentInteractionType = kInteractionAttack;
}

// update attacking
if (l_canMove && !isDashing && !isBlocking)
{
	if (!isAttacking)
	{
		meleeAtkTimer += Time.deltaTime * 2.0;
		
		if (atkButton.pressed && inCombatMode)
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
		if (dodgeButton.pressed)
		{
			meleeDashQueued = true;
			meleeAtkQueued = false;
		}
		else if (atkButton.pressed)
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