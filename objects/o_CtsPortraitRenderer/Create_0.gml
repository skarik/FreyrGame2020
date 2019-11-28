/// @description Set up renderer

depth = kUiDepthGabber + 1;

#macro kPortraitIndex_Max 8

for (var i = 0; i < kPortraitIndex_Max; ++i)
{
	state_sprite[i] = null;
	state_alpha[i] = 0.0;
	state_position[i] = 0.0;
	state_facing[i] = 1.0;
	state_blend[i] = 1.0;
	
	params_alpha[i] = 0.0;
	params_position[i] = 0.0;
	params_alignment[i] = kPortraitAlignCenter;
	
	preparams_alpha[i] = params_alpha[i];
	preparams_position[i] = params_position[i];
	preparams_alignment[i] = params_alignment[i];
}