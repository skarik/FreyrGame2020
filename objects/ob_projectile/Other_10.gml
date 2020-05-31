/// @description On Update Position

// Check against characters:
var collision_character = collision_rectangle(
	x - 4, y - 4, x + 4, y + 4, ob_character, false, true);

if (iexists(collision_character))
{
	if (damageCanHit(iexists(m_owner) ? m_owner : id, collision_character))
	{
		if (iexists(m_owner)) {
			var projectile = id;
			with (m_owner) {
				damageTarget(collision_character, projectile.m_damage, projectile.m_damageType, true, true);
			}
		}
		else {
			damageTarget(collision_character, m_damage, m_damageType, true, true);
		}
		event_user(1);
		exit;
	}
}

// Check against the collider:
//if (iexists(collision_rectangle(x - 4, y - 4, x + 4, y + 4, ob_collider, false, true)))
if (z_height <= 0.0
	|| collision3_point_meeting(x, y, z, true)
	|| collision3_point_meeting(x, y - z_height, z + z_height, true))
{
	event_user(2);
	exit;
}