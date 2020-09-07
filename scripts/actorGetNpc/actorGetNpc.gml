///@function actorGetNpc(actor_or_spawner)
///@param actor_or_spawner
function actorGetNpc(argument0) {

	var actor_or_spawner = argument0;
	if (iexists(actor_or_spawner)
		&& object_get_base_parent(actor_or_spawner.object_index) == ob_spawner)
	{
		return actor_or_spawner.m_spawned_enemy;
	}
	return actor_or_spawner;


}
