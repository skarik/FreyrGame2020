/// @description create collision

// Inherit the parent event
event_inherited();

z = collision3_get_highest_position(x, y, 0);

var collider = instance_create_depth(x, y, 0, ob_collider);
	collider.z = z;
	collider.sprite_index = sc_propMithraTestWindmill;
	collider.visible = false;
	
fader = instance_create_depth(x, y, 95, _dummy);
fader.visible = true;
fader.image_alpha = 0.0;
fader.image_blend = c_black;
fader.sprite_index = s_effectWhite64;
fader.image_xscale = 20;
fader.image_yscale = 20;

faderUpper = instance_create_depth(x, y - sprite_yoffset + sprite_height / 2, round(-y * 0.8), o_fxScreenShield);
faderUpper.width = sprite_width / 2;
faderUpper.height = sprite_height / 2;
faderUpper.visible = true;
faderUpper.image_alpha = 0.0;
faderUpper.image_blend = c_black;