/// @description Set up NPC

// Inherit the parent event
event_inherited();

m_isInteractable = false;

var standing = [
	s_charMithraGaurd0_Stand,
	s_charMithraGaurd1_Stand,
	s_charMithraGaurdS_Stand
];

var selector = id % array_length_1d(standing);

kAnimStanding = standing[selector];
kAnimWalking = kAnimStanding;
kAnimStun = kAnimStanding;

aiScriptableInit();
kAiScriptDefaultStyle = kAiStyle_Custom;
m_aiCustom_Script = aiNPCGuardUpdate;
aiNPCGuardInit();

alarm[0] = 4;

m_aiCombat_noticeAngle = 80;
m_aiCombat_noticeDistance = 159;
kAiCombat_DeAlertTime = 1.5;
kAiCombat_DeAggroTime = 5.0;