
// Cool down when player is moving:
if (sqr(m_player.xspeed) + sqr(m_player.yspeed) > sqr(m_player.kMoveSpeed * 0.2)) {
	m_farmoverlay_cooldown_movetime += Time.deltaTime;
}
else {
	m_farmoverlay_cooldown_movetime = clamp(m_farmoverlay_cooldown_movetime - Time.deltaTime * 2.0, 0.0, 0.5);
}
// if player been moviing for 0.5 seconds
if (m_farmoverlay_cooldown_movetime > 0.5)
{	// Then cooldown the fade
	m_farmoverlay_cooldown_time = max(m_farmoverlay_cooldown_time, 0.1);	
}
// Cool down when player is attacking
if (m_player.isAttacking || m_player.isBlocking)
{
	m_farmoverlay_cooldown_time = max(m_farmoverlay_cooldown_time, 1.0);
}

// Cool down when not on farm
if (!m_player.m_plantable
	&& !m_player.m_till_filldirt
	&& (!iexists(m_player.currentTillable) || (m_player.currentTillable.tilled))
	&& (!iexists(m_player.currentCrop) || !cropIsMature(m_player.currentCrop))
	)
{
	m_farmoverlay_cooldown_time = max(m_farmoverlay_cooldown_time, 0.02);
}
// Cool down when not able to farm
if (ctsGabbersHaveFocus() || !o_PlayerTest.moEnabled)
{
	m_farmoverlay_cooldown_time = max(m_farmoverlay_cooldown_time, 0.5);
}

// Blend in and out with the cooldown
if (m_farmoverlay_cooldown_time > 0)
{
	m_farmoverlay_cooldown_time -= Time.deltaTime;
	m_farmoverlay_blend = max(0.0, m_farmoverlay_blend - 4.0 * Time.deltaTime);
}
else
{
	m_farmoverlay_blend = min(1.0, m_farmoverlay_blend + 4.0 * Time.deltaTime);
}

// If visible, update the UI text & color
if (m_farmoverlay_blend > 0.0 && m_farmoverlay_cooldown_time <= 0.0)
{
	// Tillable:
	if (instance_exists(m_player.currentTillable))
	{
		m_farmoverlay_targetPosition[0] = m_player.currentTillable.x;
		m_farmoverlay_targetPosition[1] = m_player.currentTillable.y;
		m_farmoverlay_targetString = "Till";
		m_farmoverlay_targetColor = c_crystalblue;
		m_farmoverlay_targetControl = Settings.ctUse;
	}
	// Plowable:
	if (m_player.m_till_filldirt)
	{
		m_farmoverlay_targetPosition[0] = m_player.m_till_x - 8;
		m_farmoverlay_targetPosition[1] = m_player.m_till_y - 8;
		m_farmoverlay_targetString = "Plow";
		m_farmoverlay_targetColor = c_gold;
		m_farmoverlay_targetControl = Settings.ctUse;
	}
	// Plantable:
	if (m_player.m_plantable)
	{
		m_farmoverlay_targetPosition[0] = m_player.m_plant_x - 8;
		m_farmoverlay_targetPosition[1] = m_player.m_plant_y - 8;
		m_farmoverlay_targetString = "Plant";
		m_farmoverlay_targetColor = c_lime;
		m_farmoverlay_targetControl = Settings.ctUseItem;
	}
	// Crops:
	if (iexists(m_player.currentCrop))
	{
		if (cropIsMature(m_player.currentCrop))
		{
			m_farmoverlay_targetPosition[0] = m_player.currentCrop.x - 8;
			m_farmoverlay_targetPosition[1] = m_player.currentCrop.y - 8;
			m_farmoverlay_targetString = "Harvest";
			m_farmoverlay_targetColor = c_crystallime;
			m_farmoverlay_targetControl = Settings.ctUse;
		}
	}
}