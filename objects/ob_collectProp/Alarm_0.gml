/// @description Delayed initialization

if (m_hasCollision)
{
	var doodad = this;
	var collider = instance_create_depth(doodad.x, doodad.y, 0, ob_colliderDepth);
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
		//collider.source_layer = targetLayer;
	this.collider = collider;
}

depthUpdate();