/// @description ainodesLinkStart(node)
/// @param node

var sourceNode = argument0;
var kMaxLinkDistance = 250;

with (sourceNode)
{
	// reset existing links
	m_link = array_create(0);
	m_link_type = array_create(0);

	var node_count = instance_number(ob_aiNode);
	for (var i_node = 0; i_node < node_count; ++i_node)
	{
		var targetNode = instance_find(ob_aiNode, i_node);
		if (targetNode == sourceNode)
			continue; // Skip self
			
		if (sqr(targetNode.x - sourceNode.x) + sqr(targetNode.y - sourceNode.y) > sqr(kMaxLinkDistance))
		{	// Skip if too far away
			continue;
		}
		
		var valid_connection = true;
		
		// Check if the node is already linked to in the source
		for (var i = 0; i < array_length_1d(sourceNode.m_link); ++i)
		{
			if (sourceNode.m_link[i] == targetNode)
			{	// Mark that we want to skip
				valid_connection = false;
				break;
			}
		}
		if (!valid_connection)
			continue;
		// Check if the node is already linked to in the target
		/*for (var i = 0; i < array_length_1d(targetNode.m_link); ++i)
		{
			if (targetNode.m_link[i] == sourceNode)
			{	// Mark that we want to skip
				valid_connection = false;
				break;
			}
		}
		if (!valid_connection)
			continue;*/
			
		// Perform a collision check from source to target
		//var start_z = collision3_get_highest_meeting(sourceNode.x, sourceNode.y, 0);
		var current_z = z;
		var travel_distance = point_distance(sourceNode.x, sourceNode.y, targetNode.x, targetNode.y);
		var travel_direction = point_direction(sourceNode.x, sourceNode.y, targetNode.x, targetNode.y);
		var travel_step = 8.0;
		for (var dist = travel_step; dist < travel_distance; ++dist)
		{
			var check_x = sourceNode.x + lengthdir_x(dist, travel_direction);
			var check_y = sourceNode.y + lengthdir_y(dist, travel_direction);
			
			var collision = collision3_meeting(check_x, check_y, current_z, true);
			if (!collision)
			{
				current_z = collision3_get_highest_meeting(check_x, check_y, current_z);
			}
			else
			{	// Not an open connection
				valid_connection = false;
				break;
			}
		}
		
		// Add the link if we're here
		// (TODO, ensure that you can in fact go back)
		if (valid_connection)
		{
			var new_index;
			
			// Add link to the source node
			new_index = array_length_1d(sourceNode.m_link);
			sourceNode.m_link[new_index] = targetNode;
			sourceNode.m_link_type[new_index] = 0;
			
			// Add connection going back
			/*new_index = array_length_1d(targetNode.m_link);
			targetNode.m_link[new_index] = sourceNode;
			targetNode.m_link_type[new_index] = 0;*/
		}
	}
}