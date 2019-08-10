/// @description Set up NPC

// Inherit the parent event
event_inherited();

var standing = [
	s_charOasis0Stand,
	s_charOasis1Stand,
	s_charOasis2Stand,
	s_charOasis3Stand
];

var selector = id % array_length_1d(standing);

kAnimStanding = standing[selector];
kAnimWalking = kAnimStanding;
kAnimStun = kAnimStanding;

aiScriptableInit();
kAiScriptDefaultStyle = kAiStyle_Custom;
m_aiCustom_Script = aiNPCLookBusyUpdate;
aiNPCLookBusyInit();
alarm[0] = 4;