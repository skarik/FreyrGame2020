/// @function aiNPCGuard_NoticeAt(x, y)
/// @param x {Real}
/// @param y {Real}

if (!m_aiCombat_angry)
{
	if (!m_aiCombat_alerted || m_aiNPC_alertState != kAiNPCAlertState_Notice)
	{
		m_aiNPC_alertPosition = [argument0, argument1];
		m_aiCombat_alerted = true;
		m_aiNPC_alertState = kAiNPCAlertState_Notice;
		m_aiNPC_alertTimer = 0.0;
	}
}