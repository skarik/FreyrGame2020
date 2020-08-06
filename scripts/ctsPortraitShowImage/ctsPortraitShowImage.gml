/// @description ctsPortraitShowImage(index, sprite, x_pos_percent, alignment, facing)
/// @param index : Which portrait index to work on
/// @param sprite
/// @param x_pos_percent : Value from 0.0 to 1.0 to place the sprite
/// @param alignment
/// @param facing : xscale, facing left is 1.0

var index = argument0;
var sprite = argument1;
var x_pos_percent = argument2;
var alignment = argument3;
var facing = argument4;

if (!iexists(o_CtsPortraitRenderer))
	inew(o_CtsPortraitRenderer);
	
if (index < 0 || index >= kPortraitIndex_Max)
{
	debugOut("ctsPortraitShowImage() index " + string(index) + "is invalid.");
	return false;
}

var portrait_renderer = o_CtsPortraitRenderer;
with (portrait_renderer)
{
	// Set initial state fast if invisible
	if (params_alpha[index] <= 0.0)
	{
		//params_alpha[index] = 0.0;
		params_sprite[index] = sprite;
		params_position[index] = x_pos_percent;
		params_alignment[index] = alignment;
		params_facing[index] = facing;
	}
	
	// Save previous state
	preparams_sprite[index] = params_sprite[index];
	preparams_alpha[index] = params_alpha[index];
	preparams_position[index] = params_position[index];
	preparams_alignment[index] = params_alignment[index];
	preparams_facing[index] = params_facing[index];
	
	// Set new state
	if (sprite != null)
	{
		params_sprite[index] = sprite;
		params_alpha[index] = 1.0;
		params_position[index] = x_pos_percent;
		params_alignment[index] = alignment;
		params_facing[index] = facing;
	}
	else
	{
		params_sprite[index] = sprite;
		params_alpha[index] = 0.0;
	}
	
	state_blend[index] = 0.0;
}



return true;