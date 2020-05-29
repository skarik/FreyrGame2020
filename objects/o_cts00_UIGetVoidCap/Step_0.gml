/// @description Blend states

var pl = getPlayer();
var hud = pl.hud;

// Wait for the item box to go away
if (m_state == 0)
{
	if (iexists(o_CtsItemBox))
	{
		exit;
	}
	else
	{
		m_state = 1;
	}
}
// Bring the arm to the center of the screen
else if (m_state == 1)
{
	hud.m_arm_center_blend += Time.deltaTime * 2.0;
	if (hud.m_arm_center_blend > 1.0)
	{
		hud.m_arm_center_blend = 1.0;
		m_state = 2;
	}
}
// Bring in the void capacitor
else if (m_state == 2)
{
	hud.m_arm_voidcap_draw_intro = true;
	hud.m_arm_voidcap_blend += Time.deltaTime;
	// At end, enable the item in the stats
	if (hud.m_arm_voidcap_blend > 1.0)
	{
		hud.m_arm_voidcap_draw_intro = false;
		hud.m_arm_flash = 1.0;
		pl.pstats.m_pitem[kPitemVoidCapacitor] = 1;
		
		m_state = 3;
	}
}
// Fade out the flash
else if (m_state == 3)
{
	hud.m_arm_flash -= Time.deltaTime * 4.0;
	if (hud.m_arm_flash <= 0.0)
	{
		hud.m_arm_flash = 0.0;
		m_state = 4;
	}
}
// Move arm back to the corner
else if (m_state == 4)
{
	hud.m_arm_center_blend -= Time.deltaTime * 2.0;
	if (hud.m_arm_center_blend < 0.0)
	{
		hud.m_arm_center_blend = 0.0;
		idelete(this);
	}
}