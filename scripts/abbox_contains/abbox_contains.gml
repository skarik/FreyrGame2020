///@function abbox_contains(bbox, avec2 position)
///@param bbox {aBBox}
///@param position {aVec2}

var bbox = argument0;
var position = argument1;

if (position[0] >= bbox[0]
	&& position[1] >= bbox[1]
	&& position[0] <= bbox[0] + bbox[2]
	&& position[1] <= bbox[1] + bbox[3])
{
	return true;
}
return false;