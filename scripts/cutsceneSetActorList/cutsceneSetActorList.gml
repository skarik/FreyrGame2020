/// @function cutsceneSetActorList(actor_list)
/// @param actor_list {Array}

var actor_list = argument0;

if (is_array(actor_list))
{
	cts_actor_override_list_enabled = true;
	cts_actor_override_list = actor_list;
}
else
{
	cts_actor_override_list_enabled = false;
}