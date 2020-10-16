/// @description Create render list

// Force a certain level of depth for this object
depth = -1;

if (m_objectsDirty)
{	// Objects dirty? We need to do a clean
	//var list_size = ds_list_size(m_objects);
	var list_size = array_length(m_objects);
	var i = 0;
	var new_objects = array_create(0);
	
	/*for (var count = 0; count < list_size; ++count)
	{
		var object = m_objects[|i];
		// Remove items that no longer exist
		if (!instance_exists(object))
		{
			ds_list_delete(m_objects, i);
			continue;
		}
		else
		{
			++i;
		}
	}*/
	
	for (var i_old = 0; i_old < list_size; ++i_old)
	{
		var object = m_objects[i_old];
		if (object != null && instance_exists(object))
		{
			// Save valid object
			new_objects[i] = object;
			// Set new depth system index
			object.m_depthState.index = i;
			// Prepare next index
			i++;
		}
	}
	m_objects = new_objects;
	
	m_objectsDirty = false;
}

// Recreate a queue now
//ds_list_clear(m_renderQueue);
{
	var render_sorted = ds_priority_create();
	
	//var list_size = ds_list_size(m_objects);
	var list_size = array_length(m_objects);
	for (var i = 0; i < list_size; ++i)
	{
		//var object = m_objects[|i];
		var object = m_objects[i];
		//if (instance_exists(object))
		if (object != null) // Should always exist
		{
			if (object.visible)
			{	// If object is visible, add it to the render queue.
				var object_priority = object.m_depthState.depth;
				if (object.m_depthState.worldDraw == depthWorldDrawSelf)
				{
					object_priority -= 0;
				}
				else if (object.m_depthState.worldDraw == depthWorldDraw_Particle1)
				{
					object_priority -= 10000;
				}
				else if (object.m_depthState.worldDraw == depthWorldDraw_DoodadTreeWiggle)
				{
					object_priority -= 20000;
				}
				else
				{
					object_priority -= 30000;
				}
				ds_priority_add(render_sorted, object, object_priority);
			}
		}
		else
		{
			m_objectsDirty = true;
		}
	}
	
	// Pull out the queue values
	var sorted_size = ds_priority_size(render_sorted);
	m_renderQueue = array_create(sorted_size);
	for (var i = sorted_size - 1; i >= 0; --i)
	{
		//ds_list_add(m_renderQueue, ds_priority_delete_max(render_sorted));
		m_renderQueue[i] = ds_priority_delete_min(render_sorted);
	}
	
	// Done with the sorting structure
	ds_priority_destroy(render_sorted);
}

// Run pre-render on the queue
//var renderQueueSize = ds_list_size(m_renderQueue);
var renderQueueSize = array_length(m_renderQueue);
for (var i = 0; i < renderQueueSize; ++i)
{
	//var object = m_renderQueue[|i];
	var object = m_renderQueue[i];
	var func = object.m_depthState.shadowPredraw;
	with (object) func();
}