var object_target = argument0;
var count = argument1;

var target_inst = null;

// Using normal actor spawning tracking list
if (!cts_actor_override_list_enabled
	&& array_length_1d(cts_actor_tracking_list) > 0)
{
	var current_count = 0;
	
	// Look through the tracking spawn list
	for (var i = 0; i < array_length_1d(cts_actor_tracking_list); ++i)
	{
		var potential_inst = cts_actor_tracking_list[i];
		if (iexists(potential_inst)
			&& potential_inst.object_index == object_target)
		{	// If it's a match, count it
			if (current_count == count)
			{
				target_inst = potential_inst;
				break; // We're done searching.
			}
			current_count++;
		}
	}
}

if (cts_actor_override_list_enabled
	&& !iexists(target_inst))
{
	// Move it into offset range
	var target = object_target - SEQI_TARGET_OFFSET_INDEX;
	// Check it's in the offset range
	if (   target >= 0
		&& target < array_length_1d(cts_actor_override_list))
	{
		target_inst = cts_actor_override_list[target];
	}
}

// Default finding instance
if (target_inst == null)
{
	target_inst = instance_find(object_target, count);
}

// Forward references to spawners
if (iexists(target_inst) && object_get_base_parent(target_inst.object_index) == ob_spawner)
{
	target_inst = target_inst.m_spawned_enemy;
}

// Default non-instance
if (!iexists(target_inst))
{
	target_inst = object_target;
}

return target_inst;