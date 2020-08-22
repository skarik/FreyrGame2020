///@function abbox_encompassTo(bbox, avec2 position)
///@param bbox {aBBox}
///@param position {aVec2}

var bbox = argument0;
var position = argument1;

if (position[0] < bbox[0])
{
	var delta = bbox[0] - position[0];
	bbox[0] -= delta;
	bbox[2] += delta;
}
if (position[0] > bbox[0] + bbox[2])
{
	var delta = position[0] - (bbox[0] + bbox[2]);
	bbox[2] += delta;
}

if (position[1] < bbox[1])
{
	var delta = bbox[1] - position[1];
	bbox[1] -= delta;
	bbox[3] += delta;
}
if (position[1] > bbox[1] + bbox[3])
{
	var delta = position[1] - (bbox[1] + bbox[3]);
	bbox[3] += delta;
}



return bbox;