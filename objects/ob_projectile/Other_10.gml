/// @description On Update Position

// Check against characters:
var collision_character = collision_rectangle(
	x - 4, y - 4, x + 4, y + 4, ob_character, false, true);

if (exists(collision_character))
{
	if (damageCanHit(exists(m_owner) ? m_owner : id, collision_character))
	{
		if (exists(m_owner)) {
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
if (exists(collision_rectangle(x - 4, y - 4, x + 4, y + 4, ob_collider, false, true)))
{
	event_user(2);
	exit;
}