/// @description Set up renderer

event_inherited();

depth = kUiDepthGabber + 1;

#macro kPortraitIndex_Max 8

for (var i = 0; i < kPortraitIndex_Max; ++i)
{
	state_sprite[i] = null;
	state_alpha[i] = 0.0;
	state_position[i] = 0.0;
	state_facing[i] = 1.0;
	state_blend[i] = 1.0;
	state_alignment[i] = 0.0;
	
	params_sprite[i] = null;
	params_alpha[i] = 0.0;
	params_position[i] = 0.0;
	params_alignment[i] = kPortraitAlignCenter;
	params_facing[i] = 0.0;
	
	preparams_sprite[i] = params_sprite[i];
	preparams_alpha[i] = params_alpha[i];
	preparams_position[i] = params_position[i];
	preparams_alignment[i] = params_alignment[i];
	preparams_facing[i] = params_facing[i];
}