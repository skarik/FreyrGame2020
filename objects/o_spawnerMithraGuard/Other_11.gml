/// @description On Character Spawned

// m_spawned_enemy is now pointing to an instance.

with (m_spawned_enemy)
{
	m_patrolPathStart = other.m_patrolPathStart;
	m_ai_disableAggression = other.m_ai_disableAggression;
}