/// @description Set up NPC

// Inherit the parent event
event_inherited();

var standing = [
	s_charMithra0_Stand,
	s_charMithra1_Stand,
	s_charMithra2_Stand,
	s_charMithra3_Stand,
	s_charMithra4_Stand,
	s_charMithra5_Stand,
	
	s_charMithra9_Stand,
	s_charMithra10_Stand,
	
	s_charMithra6_Stand,
	s_charMithra6_Stand,
	s_charMithra7_Stand,
	s_charMithra7_Stand,
	s_charMithra8_Stand,
	s_charMithra8_Stand,
];

var selector = id % array_length_1d(standing);

kAnimStanding = standing[selector];
kAnimWalking = kAnimStanding;
kAnimStun = kAnimStanding;

aiScriptableInit();
kAiScriptDefaultStyle = kAiStyle_Default; //kAiStyle_Custom;
m_aiCustom_Script = aiNPCLookBusyUpdate;
aiNPCLookBusyInit();

facingDirection = 90 * (id % 4);//choose(0, 90, 180, 270);
aimingDirection = facingDirection;

if (m_hasBehavior)
	alarm[0] = 4 + floor(random(400));