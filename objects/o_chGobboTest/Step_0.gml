/// @description AI


aiScriptableUpdate();


// Inherit the parent event
event_inherited();

// TODO: move the following to a defaul type of health/stamina shown
var pl = getPlayer();
var pl_dist = sqr(1024);
if (exists(pl)) pl_dist = sqr(x - pl.x) + sqr(y - pl.y);
// Update health showing
if (m_aiCombat_angry || stats.m_health < stats.m_healthMax || pl_dist < sqr(48)) 
	m_uiwantsHealthShown = true;
else
	m_uiwantsHealthShown = false;
	
if (m_aiCombat_angry || stats.m_health < stats.m_healthMax || stats.m_stun > 0 || pl_dist < sqr(48))
	m_uiwantsStaminaShown = true;
else
	m_uiwantsStaminaShown = false;