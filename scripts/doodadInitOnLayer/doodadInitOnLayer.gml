var targetLayer = argument0;
var shadowed = argument1;

var do_collision = string_pos("colli", layer_get_name(targetLayer)) != 0;
var do_breakable = string_pos("break", layer_get_name(targetLayer)) != 0;
var layerDepth = layer_get_depth(targetLayer);

var doodad_type = do_breakable ? ob_doodadBreakable : (shadowed ? ob_doodad : ob_doodadNoShadow);

var elements = layer_get_all_elements(targetLayer);
for (var i = 0; i < array_length_1d(elements); ++i)
{
	var element = elements[i];
	var element_type = layer_get_element_type(element);
	if (element_type == layerelementtype_sprite)
	{
		var final_doodad_type = doodad_type;
		var final_doodad_sprite = layer_sprite_get_sprite(element);
		final_doodad_type = doodadSetFinalType(doodad_type, final_doodad_sprite);
		
		// Create a doodad and delete the sprite
		var doodad = instance_create_depth(layer_sprite_get_x(element), layer_sprite_get_y(element), 0, final_doodad_type);
			doodad.z = collision3_get_highest_position(doodad.x, doodad.y, abs(layerDepth));
			doodad.sprite_index = final_doodad_sprite;
			doodad.image_index = layer_sprite_get_index(element);
			doodad.image_speed = layer_sprite_get_speed(element);
			doodad.image_xscale = layer_sprite_get_xscale(element);
			doodad.image_yscale = layer_sprite_get_yscale(element);
			doodad.image_angle = layer_sprite_get_angle(element);
			doodad.image_blend = layer_sprite_get_blend(element);
			doodad.image_alpha = layer_sprite_get_alpha(element);
			doodad.collider = null;
			doodad.light = null;
			doodad.emissive = null;
			doodad.source_layer = targetLayer;
		
		doodadSetGlow(doodad);
		doodadSetShadow(doodad);
			
		if (do_collision)
		{
			var collider = instance_create_depth(doodad.x, doodad.y, 0, ob_colliderDepth);
				//collider.z = layerDepth;
				collider.z = doodad.z;
				collider.sprite_index = doodad.sprite_index;
				collider.image_index = doodad.image_index;
				collider.image_speed = doodad.image_speed;
				collider.image_xscale = doodad.image_xscale;
				collider.image_yscale = doodad.image_yscale;
				collider.image_angle = doodad.image_angle;
				collider.image_blend = doodad.image_blend;
				collider.image_alpha = doodad.image_alpha;
				collider.visible = false;
				collider.source_layer = targetLayer;
			doodad.collider = collider;
		}
		
		// Do user-post info
		with (doodad)
			event_user(1);
		
		layer_sprite_destroy(element);
	}
}