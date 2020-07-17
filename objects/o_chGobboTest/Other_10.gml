/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

dropItems(kDropSeparateChances,[
	[o_pickupCons_ScorpStick, 0.33, 1],
	[o_pickupCons_HoneyAbsinthe, 0.25, 1],
]);
