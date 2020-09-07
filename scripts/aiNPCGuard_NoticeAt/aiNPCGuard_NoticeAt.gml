/// @function aiNPCGuard_NoticeAt(x, y)
/// @param x {Real}
/// @param y {Real}
function aiNPCGuard_NoticeAt(argument0, argument1) {

	if (!m_aiCombat_angry)
	{
		if (!m_aiCombat_alerted || m_aiNPC_alertState != kAiNPCAlertState_Notice)
		{
			m_aiNPC_alertPosition = [argument0, argument1];
			event_user(kEvent_AIOnAlert11);
			m_aiNPC_alertState = kAiNPCAlertState_Notice;
			m_aiNPC_alertTimer = 0.0;
		}
	}


}
