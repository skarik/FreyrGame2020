/// @description Set up NPC

// Inherit the parent event
event_inherited();

var standing = [
	s_charMithra0_Stand,
	s_charMithra0_Stand,
	s_charMithra1_Stand,
	s_charMithra1_Stand,
	s_charMithra2_Stand
];

var selector = id % array_length_1d(standing);

kAnimStanding = standing[selector];
kAnimWalking = kAnimStanding;
kAnimStun = kAnimStanding;

aiScriptableInit();
kAiScriptDefaultStyle = kAiStyle_Default; //kAiStyle_Custom;
m_aiCustom_Script = aiNPCLookBusyUpdate;
aiNPCLookBusyInit();
//alarm[0] = 4;