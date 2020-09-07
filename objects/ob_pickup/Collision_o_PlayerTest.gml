if (m_canPickUp && !m_isPickingUp && m_pickupCooldown <= 0.0)
{
	// Get picked up by the player!
	m_isPickingUp = true;
	m_pickupTarget = other.id;
	m_pickupCooldown = kPickupTime * 3;
	
	m_pickupStartX = x;
	m_pickupStartY = y;
}