/// @description ainodesGetClosest(x, y, z, less_than_only)
/// @param x
/// @param y
/// @param z
/// @param less_than_only

var tx = argument0;
var ty = argument1;
var tz = argument2;
var falling = argument3;

var minDistance = room_width * room_height * 3;
var minNode = null;

var nodeCount = instance_number(ob_aiNode);
for (var i = 0; i < nodeCount; ++i)
{
	var node = instance_find(ob_aiNode, i);
	if (falling ? (node.z > tz + 4) : (abs(node.z - tz) > 4))
		continue; // Skip the node if out of Z range
		
	var dist = sqr(tx - node.x) + sqr(ty - node.y);
	if (dist < minDistance)
	{
		minDistance = dist;
		minNode = node;
	}
}

return minNode;