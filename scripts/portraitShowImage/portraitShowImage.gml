/// @description portraitShowImage(index, sprite, x_pos_percent, alignment, facing)
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

if (!exists(o_CtsPortraitRenderer))
	new(o_CtsPortraitRenderer);
	
if (index < 0 || index >= kPortraitIndex_Max)
{
	debugOut("portraitShowImage() index " + string(index) + "is invalid.");
	return false;
}

var portrait_renderer = o_CtsPortraitRenderer;
with (portrait_renderer)
{
	// Save previous state
	
	// Set new state
	state_sprite[index] = sprite;
	params_alpha[index] = 1.0;
	params_position[index] = x_pos_percent;
	params_alignment[index] = alignment;
	state_facing[index] = facing;
	
	state_blend[index] = 0.0;
}



return true;