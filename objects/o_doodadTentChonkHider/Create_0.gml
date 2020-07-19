/// @description create collision

// Inherit the parent event
event_inherited();

z = collision3_get_highest_position(x, y, 0);

var collider = instance_create_depth(x, y, 0, ob_collider);
	//collider.z = layerDepth;
	collider.sprite_index = sc_tentChonk;
	collider.visible = false;
	
fader = instance_create_depth(x, y - 48, 95, _dummy);
fader.visible = true;
fader.image_alpha = 0.0;
fader.image_blend = c_black;
fader.sprite_index = s_effectWhite64;
fader.image_xscale = 2;
fader.image_yscale = 2;

faderUpper = instance_create_depth(x, y - 48, round(-y * 0.8), o_fxScreenShield);
faderUpper.width = 32 * fader.image_xscale;
faderUpper.height = 32 * fader.image_xscale;
faderUpper.visible = true;
faderUpper.image_alpha = 0.0;
faderUpper.image_blend = c_black;