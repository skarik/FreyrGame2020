function aicommonCombatInit() {
	m_hasCombatAi = true; // Mark character as having combat AI

	m_ai_disableAggression = false;

	m_aiCombat_enabled = true;
	m_aiCombat_angry = false;
	m_aiCombat_alerted = false;

	m_aiCombat_aggroTimer = 0;
	m_aiCombat_deaggroTimer = 0;

	m_aiCombat_noticeAngle = 45;
	m_aiCombat_noticeDistance = 192;
	m_aiCombat_combatDistance = 212;

	m_aiCombat_target = null;
	m_aiCombat_targetPosition = [0, 0];
	m_aiCombat_targetVisible = false;
	m_aiCombat_targetTrackingLossTime = 0.0;
	m_aiCombat_updateInterval = 0;

	kAiCombat_DeAlertTime = 5.0;
	kAiCombat_DeAggroTime = 2.0;

	aiGAlertInit();


}
