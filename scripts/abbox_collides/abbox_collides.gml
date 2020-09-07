///@function abbox_collides(bbox1, bbox2)
///@param bbox1
///@param bbox2
function abbox_collides(argument0, argument1) {

	var bbox1 = argument0;
	var bbox2 = argument1;

	return (bbox1[0] < bbox2[0] + bbox2[2]) && (bbox1[0] + bbox1[2] > bbox2[0])
		&& (bbox1[1] < bbox2[1] + bbox2[3]) && (bbox1[1] + bbox1[3] > bbox2[1]);


}
