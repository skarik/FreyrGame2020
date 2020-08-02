var startingNode = argument0;
var endingNode = argument1;

if (!iexists(startingNode) || !iexists(endingNode) || startingNode == endingNode)
{
	m_aipath_current = null;
	return false;
}

var nodesVisited = ds_list_create();
//var nodesQueued = ds_list_create();
var nodesQueued = ds_priority_create();

var nodeTotalScores = ds_map_create();
var nodeTravelScores = ds_map_create();
var nodeCameFrom = ds_map_create();

// Start with the starting node
//ds_list_add(nodesQueued, startingNode);
ds_priority_add(nodesQueued, startingNode, 0.0);
ds_map_add(nodeTotalScores, startingNode, 0.0);
ds_map_add(nodeTravelScores, startingNode, 0.0);

//while (!ds_list_empty(nodesQueued))
while (!ds_priority_empty(nodesQueued))
{
	//var currentNode = nodesQueued[|0];
	var currentNode = ds_priority_delete_min(nodesQueued);
	//var currentNodeQueueIndex = 0;
	//var lowestScore = nodeTotalScores[?startingNode];
	
	// Find node in the queue with the lowest cost
	/*for (var i = 1; i < ds_list_size(nodesQueued); ++i)
	{
		var node = nodesQueued[|i];
		var nscore = nodeTotalScores[?node];
		if (nscore < lowestScore)
		{
			lowestScore = nscore;
			currentNode = node;
			currentNodeQueueIndex = i;
		}
	}*/
	
	// If the node is invalid, we're in a bad spot
	if (is_undefined(currentNode) || currentNode == null)
	{
		m_aipath_listing = null;
		
		// Kill loop
		break;
	}
	
	// If the current node is the goal, we're done
	if (currentNode == endingNode)
	{
		// Create the path
		var finalPath = ds_list_create();
		ds_list_add(finalPath, currentNode);
		
		// Loop backwards to find the source path
		do
		{
			currentNode = ds_map_find_value(nodeCameFrom, currentNode);
			if (!is_undefined(currentNode))
			{	// Add to the final path
				ds_list_insert(finalPath, 0, currentNode);
			}
		}
		until (is_undefined(currentNode));
		
		// Now make the list an array
		m_aipath_listing = array_create(ds_list_size(finalPath));
		for (var i = 0; i < ds_list_size(finalPath); ++i)
		{
			m_aipath_listing[i] = finalPath[|i];
		}
		
		ds_list_destroy(finalPath);
		
		// Kill loop
		break;
	}
	
	// Remove from queue, add to visited
	//ds_list_delete(nodesQueued, currentNodeQueueIndex);
	ds_list_add(nodesVisited, currentNode);
	
	// Loop through the links and judge them, all judge-like
	var link_count = array_length_1d(currentNode.m_link);
	for (var i = 0; i < link_count; ++i)
	{
		var neighbor = currentNode.m_link[i];
		
		// Skip if it's been visited
		if (ds_list_find_index(nodesVisited, neighbor) != -1)
			continue;
			
		// Set the neighbors' travel scores
		var distance_to_neighbor = sqr(currentNode.x - neighbor.x) + sqr(currentNode.y - neighbor.y);
		var tenative_travel_score = nodeTravelScores[?currentNode] + distance_to_neighbor;
		
		// Discover nodes
		var neighbor_travel_score = nodeTravelScores[?neighbor];
		if (!is_undefined(neighbor_travel_score)
			&& tenative_travel_score >= neighbor_travel_score)
			continue; // Skip if the travel score is higher (not better)
		
		var distance_to_goal = sqr(endingNode.x - neighbor.x) + sqr(endingNode.y - neighbor.y);
		var tenative_total_travel_score = tenative_travel_score + distance_to_goal;
		
		nodeCameFrom[?neighbor] = currentNode;
		nodeTravelScores[?neighbor] = tenative_travel_score;
		nodeTotalScores[?neighbor] = tenative_total_travel_score;
		
		// Update the node in the queue
		if (ds_priority_find_priority(nodesQueued, neighbor) == undefined)
			ds_priority_add(nodesQueued, neighbor, tenative_total_travel_score);
		else
			ds_priority_change_priority(nodesQueued, neighbor, tenative_total_travel_score);
		
		// Discover nodes
		/*if (ds_list_find_index(nodesQueued, neighbor) == -1)
			ds_list_add(nodesQueued, neighbor);
		else if (ds_map_exists(nodeTravelScores, neighbor)
			&& tenative_travel_score >= nodeTravelScores[?neighbor])
			continue; // Skip if the travel score is higher (not better)
		
		// Record the best path so far & scores
		var distance_to_goal = sqr(endingNode.x - neighbor.x) + sqr(endingNode.y - neighbor.y);
		nodeCameFrom[?neighbor] = currentNode;
		nodeTravelScores[?neighbor] = tenative_travel_score;
		nodeTotalScores[?neighbor] = tenative_travel_score + distance_to_goal;*/
	}
}

ds_list_destroy(nodesVisited);
//ds_list_destroy(nodesQueued);
ds_priority_destroy(nodesQueued);
ds_map_destroy(nodeTotalScores);
ds_map_destroy(nodeTravelScores);
ds_map_destroy(nodeCameFrom);

return true;