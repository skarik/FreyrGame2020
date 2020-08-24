/// @description Do portrait blends

// background blend first
if (state_background == null)
{
	state_background_alpha = 0.0;
}
if (params_background != null)
{
	state_background = params_background;
}
state_background_alpha = motion1d_to(state_background_alpha, params_background_alpha, Time.deltaTime * 4.0);

for (var i = 0; i < kPortraitIndex_Max; ++i)
{
	// Skip invalid portrait states
	if (state_sprite[i] == null && params_sprite[i] == null && preparams_sprite[i] == null) 
	{
		state_alpha[i] = 0.0;
		state_blend[i] = 1.0;
		continue;
	}
	
	// Update facing (TODO)
	
	// Begin blending to state
	state_blend[i] = saturate(state_blend[i] + Time.deltaTime * 4.0);
	
	// Create position to place portraits
	//var width = sprite_get_width(state_sprite[i]);
	/*var width = 200.0;
	if (sprite_exists(params_sprite[i]))
	{
		if (sprite_exists(preparams_sprite[i]))
		{
			//width = lerp(sprite_get_width(preparams_sprite[i]), sprite_get_width(params_sprite[i]), state_blend[i]);
			width = sprite_get_width(params_sprite[i]);
		}
		else
		{
			width = sprite_get_width(params_sprite[i]);
		}
	}
	else
	{
		if (sprite_exists(preparams_sprite[i]))
		{
			width = sprite_get_width(preparams_sprite[i]);
		}
	}*/
	
	// Generate the two positions
	var position = params_position[i] * GameCamera.width;
	/*if (params_alignment[i] == kPortraitAlignCenter) {
		position += width * 0.5 * state_facing[i];
	}
	else if (params_alignment[i] == kPortraitAlignLeft && state_facing[i] < 0.0) {
		position += width;
	}
	else if (params_alignment[i] == kPortraitAlignRight && state_facing[i] > 0.0) {
		position -= width;
	}*/
	
	var preposition = preparams_position[i] * GameCamera.width;
	/*if (preparams_alignment[i] == kPortraitAlignCenter) {
		preposition += width * 0.5 * state_facing[i];
	}
	else if (preparams_alignment[i] == kPortraitAlignLeft && state_facing[i] < 0.0) {
		preposition += width;
	}
	else if (preparams_alignment[i] == kPortraitAlignRight && state_facing[i] > 0.0) {
		preposition -= width;
	}*/
	
	var alignment = 0.0;
	if (params_alignment[i] == kPortraitAlignCenter) {
		alignment = 0.0;
	}
	else if (params_alignment[i] == kPortraitAlignLeft) {
		alignment = -1.0;
	}
	else if (params_alignment[i] == kPortraitAlignRight) {
		alignment = +1.0;
	}
	
	var prealignment = 0.0;
	if (preparams_alignment[i] == kPortraitAlignCenter) {
		prealignment = 0.0;
	}
	else if (preparams_alignment[i] == kPortraitAlignLeft) {
		prealignment = -1.0;
	}
	else if (preparams_alignment[i] == kPortraitAlignRight) {
		prealignment = +1.0;
	}
	
	// Blend to state
	state_position[i] = lerp(preposition, position, smoothstep(state_blend[i]));
	state_alpha[i] = lerp(preparams_alpha[i], params_alpha[i], state_blend[i]);
	
	// update sprite
	if (params_sprite[i] != null)
	{
		state_sprite[i] = params_sprite[i];
	}
	else
	{
		if (state_alpha[i] <= 0.0)
		{	// set preparams to null so the optimized skip can kick in
			state_sprite[i] = null;
			preparams_sprite[i] = null;
		}
	}
	
	state_facing[i] = lerp(preparams_facing[i], params_facing[i], state_blend[i]);
	state_alignment[i] = lerp(prealignment, alignment, state_blend[i]);
}