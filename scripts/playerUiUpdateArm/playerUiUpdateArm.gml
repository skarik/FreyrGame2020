
//m_arm_healthbar_percent

var pl = getPlayer();
if (exists(pl))
{
	var l_target = saturate(pl.stats.m_health / pl.stats.m_healthMax);
	var l_delta = l_target - m_arm_healthbar_percent;
	var l_speed = 0.75 * Time.deltaTime;
	
	// Change health visual gradually
	if (abs(l_delta) < l_speed)
		m_arm_healthbar_percent += l_delta;
	else
		m_arm_healthbar_percent += sign(l_delta) * l_speed;
}