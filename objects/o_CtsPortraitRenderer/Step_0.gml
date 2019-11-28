/// @description Do portrait blends

for (var i = 0; i < kPortraitIndex_Max; ++i)
{
	// Skip invalid portrait states
	if (state_sprite[i] == null) 
	{
		state_alpha[i] = 0.0;
		state_blend[i] = 1.0;
		continue;
	}
	
	// Update facing (TODO)
	
	// Create position to place portraits
	var width = sprite_get_width(state_sprite[i]);
	var position = params_position[i] * GameCamera.width;
	if (params_alignment[i] == kPortraitAlignCenter) {
		position += width * 0.5 * state_facing[i];
	}
	else if (params_alignment[i] == kPortraitAlignLeft && state_facing[i] < 0.0) {
		position += width;
	}
	else if (params_alignment[i] == kPortraitAlignRight && state_facing[i] > 0.0) {
		position -= width;
	}
	
	var preposition = preparams_position[i] * GameCamera.width;
	if (preparams_alignment[i] == kPortraitAlignCenter) {
		preposition += width * 0.5 * state_facing[i];
	}
	else if (preparams_alignment[i] == kPortraitAlignLeft && state_facing[i] < 0.0) {
		preposition += width;
	}
	else if (preparams_alignment[i] == kPortraitAlignRight && state_facing[i] > 0.0) {
		preposition -= width;
	}
	
	// Blend to state
	state_blend[i] = saturate(state_blend[i] + Time.deltaTime * 4.0);

	state_position[i] = lerp(preposition, position, state_blend[i]);
	state_alpha[i] = lerp(preparams_alpha[i], params_alpha[i], state_blend[i]);
	
	/*state_sprite[i] = null;
	state_alpha[i] = 0.0;
	state_position[i] = 0.0;
	state_facing[i] = 1.0;
	state_blend[i] = 1.0;
	
	params_alpha[i] = 0.0;
	params_position[i] = 0.0;
	params_alignment[i] = kPortraitAlignCenter;
	
	preparams_alpha[i] = params_alpha[i];
	preparams_position[i] = params_position[i];
	preparams_alignment[i] = params_alignment[i];*/
}